-- Stability improvements for LazyVim

-- Enhanced safe require function with retry mechanism (simplified for headless)
local function safe_require(module, max_retries)
  max_retries = max_retries or 2
  local retries = 0

  while retries < max_retries do
    local ok, result = pcall(require, module)
    if ok then
      return result
    end

    retries = retries + 1
    if retries < max_retries then
      -- Skip retries in headless mode to avoid timeouts
      if vim.fn.argc() == 0 then
        vim.notify("Retrying load of module: " .. module .. " (attempt " .. retries .. ")", vim.log.levels.WARN)
      end
    else
      if vim.fn.argc() == 0 then
        vim.notify("Failed to load module after " .. max_retries .. " attempts: " .. module, vim.log.levels.ERROR)
      end
      return nil
    end
  end
  return nil
end

-- Global error handler with enhanced monitoring
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("GlobalErrorHandler", { clear = true }),
  callback = function()
    -- Only run in interactive mode
    if vim.fn.argc() > 0 then return end
    
    vim.defer_fn(function()
      -- Check for critical plugins
      local critical_plugins = { "nvim-treesitter", "lazy.nvim", "which-key.nvim" }

      for _, plugin in ipairs(critical_plugins) do
        if not safe_require(plugin) then
          vim.notify("Critical plugin " .. plugin .. " failed to load", vim.log.levels.WARN)
        end
      end

      -- Memory usage monitoring
      local mem_kb = tonumber(vim.fn.system("ps -o rss= -p " .. vim.fn.getpid()):gsub("%s+", "")) or 0
      if mem_kb > 500000 then -- 500MB threshold
        vim.notify("High memory usage detected: " .. math.floor(mem_kb/1024) .. "MB", vim.log.levels.WARN)
      end
    end, 1000)
  end,
})

-- Safe keymap wrapper with validation
local function safe_keymap(mode, lhs, rhs, opts)
  opts = opts or {}

  -- Validate inputs
  if type(mode) ~= "string" or type(lhs) ~= "string" then
    vim.notify("Invalid keymap parameters", vim.log.levels.ERROR)
    return false
  end

  local success, err = pcall(vim.keymap.set, mode, lhs, rhs, opts)
  if not success then
    vim.notify("Failed to set keymap " .. lhs .. ": " .. tostring(err), vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Plugin crash recovery
local function recover_plugin(plugin_name)
  vim.notify("Attempting to recover plugin: " .. plugin_name, vim.log.levels.INFO)

  -- Try to reload the plugin
  local ok, plugin = pcall(require, plugin_name)
  if ok then
    vim.notify("Successfully recovered plugin: " .. plugin_name, vim.log.levels.INFO)
    return true
  end

  -- Fallback: try to reinstall via lazy
  if safe_require("lazy") then
    vim.defer_fn(function()
      vim.cmd("Lazy install " .. plugin_name)
    end, 1000)
  end

  return false
end

-- Export safe functions
_G.safe_require = safe_require
_G.safe_keymap = safe_keymap
_G.recover_plugin = recover_plugin

-- Enhanced health check command
vim.api.nvim_create_user_command("HealthCheck", function()
  local health = {}

  -- Check Neovim version
  table.insert(health, "Neovim version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)

  -- Check critical plugins
  local plugins = {
    "lazy.nvim",
    "nvim-treesitter",
    "blink.cmp",
    "lspconfig",
    "telescope",
    "which-key",
    "gitsigns",
    "todo-comments",
  }

  local failed_plugins = {}
  for _, plugin in ipairs(plugins) do
    local ok = pcall(require, plugin)
    local status = ok and "✓ OK" or "✗ FAILED"
    table.insert(health, plugin .. ": " .. status)
    if not ok then
      table.insert(failed_plugins, plugin)
    end
  end

  -- Check memory
  local mem_kb = tonumber(vim.fn.system("ps -o rss= -p " .. vim.fn.getpid()):gsub("%s+", "")) or 0
  table.insert(health, "Memory usage: " .. math.floor(mem_kb/1024) .. " MB")

  -- Check LSP servers
  local lsp_servers = { "lua_ls", "pyright", "clangd", "bashls", "jsonls", "yaml_ls" }
  local lsp_ok = 0
  for _, server in ipairs(lsp_servers) do
    local lspconfig = safe_require("lspconfig")
    if lspconfig and lspconfig[server] then
      lsp_ok = lsp_ok + 1
    end
  end
  table.insert(health, "LSP servers: " .. lsp_ok .. "/" .. #lsp_servers .. " available")

  -- Check for configuration errors
  local config_files = {
    "~/.config/nvim/init.lua",
    "~/.config/nvim/lua/config/lazy.lua",
    "~/.config/nvim/lua/config/options.lua",
  }

  for _, file in ipairs(config_files) do
    local full_path = vim.fn.expand(file)
    if vim.fn.filereadable(full_path) == 1 then
      table.insert(health, file .. ": ✓ Present")
    else
      table.insert(health, file .. ": ✗ Missing")
    end
  end

  -- Display results
  local result = "Health Check Results:\n" .. table.concat(health, "\n")

  if #failed_plugins > 0 then
    result = result .. "\n\nFailed plugins: " .. table.concat(failed_plugins, ", ")
    result = result .. "\nRun :RecoverPlugin <name> to attempt recovery"
  end

  vim.notify(result, vim.log.levels.INFO)
end, { desc = "Run configuration health check" })

-- Plugin recovery command
vim.api.nvim_create_user_command("RecoverPlugin", function(opts)
  if opts.args and opts.args ~= "" then
    recover_plugin(opts.args)
  else
    vim.notify("Usage: :RecoverPlugin <plugin_name>", vim.log.levels.ERROR)
  end
end, { nargs = 1, desc = "Recover a failed plugin" })

-- Backup configuration command
vim.api.nvim_create_user_command("BackupConfig", function()
  local backup_dir = vim.fn.expand("~/.config/nvim/backups")
  vim.fn.mkdir(backup_dir, "p")
  local timestamp = os.date("%Y%m%d_%H%M%S")
  local backup_file = backup_dir .. "/nvim_backup_" .. timestamp .. ".tar.gz"

  vim.cmd("!tar -czf " .. backup_file .. " -C ~/.config nvim")
  vim.notify("Config backed up to: " .. backup_file)
end, { desc = "Backup Neovim configuration" })

-- Auto-recovery on crashes
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("AutoRecovery", { clear = true }),
  callback = function()
    local session_file = vim.fn.expand("~/.config/nvim/session.vim")
    vim.cmd("mks! " .. session_file)
  end,
})

-- Restore session if available
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("SessionRestore", { clear = true }),
  callback = function()
    local session_file = vim.fn.expand("~/.config/nvim/session.vim")
    if vim.fn.filereadable(session_file) == 1 and vim.fn.argc() == 0 then
      vim.defer_fn(function()
        vim.cmd("source " .. session_file)
      end, 100)
    end
  end,
})

-- Memory cleanup command
vim.api.nvim_create_user_command("CleanMemory", function()
  -- Force garbage collection
  collectgarbage("collect")

  -- Clear unused buffers
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if not vim.api.nvim_buf_is_loaded(buf) and not vim.api.nvim_buf_get_option(buf, 'modified') then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  vim.notify("Memory cleanup completed", vim.log.levels.INFO)
end, { desc = "Clean up memory usage" })

-- Periodic health check (every 10 minutes) - only in interactive mode
if vim.fn.has("gui_running") == 0 and vim.fn.argc() == 0 then
  vim.defer_fn(function()
    local health_check_timer = vim.loop.new_timer()
    if health_check_timer then
      health_check_timer:start(600000, 600000, vim.schedule_wrap(function()
        local mem_kb = tonumber(vim.fn.system("ps -o rss= -p " .. vim.fn.getpid()):gsub("%s+", "")) or 0
        if mem_kb > 800000 then -- 800MB threshold
          vim.notify("Critical memory usage: " .. math.floor(mem_kb/1024) .. "MB. Consider running :CleanMemory", vim.log.levels.WARN)
        end
      end))
    end
  end, 2000)
end

-- Error logging
local log_file = vim.fn.expand("~/.config/nvim/stability.log")
local function log_error(message)
  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  local log_entry = "[" .. timestamp .. "] " .. message .. "\n"
  
  -- Check if log file exists, if not create it
  if vim.fn.filereadable(log_file) == 0 then
    vim.fn.writefile({log_entry}, log_file)
  else
    local existing_logs = vim.fn.readfile(log_file)
    table.insert(existing_logs, log_entry)
    vim.fn.writefile(existing_logs, log_file)
  end
end

-- Override vim.notify to also log errors
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  original_notify(msg, level, opts)
  if level == vim.log.levels.ERROR then
    log_error(tostring(msg))
  end
end