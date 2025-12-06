-- Performance optimizations for LazyVim

-- Disable some built-in plugins for performance
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Additional stability settings
vim.opt.history = 1000 -- Reduce history size
vim.opt.undolevels = 1000 -- Limit undo levels
vim.opt.redrawtime = 1500 -- Limit redraw time
vim.opt.maxmempattern = 1000 -- Limit pattern memory
vim.opt.completeopt = "menu,menuone,noselect" -- Better completion behavior

-- Optimize for large files
vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("LargeFileOptimizations", { clear = true }),
  callback = function()
    local size = vim.fn.getfsize(vim.fn.expand("%:p"))
    if size > 1024 * 1024 then -- 1MB
      vim.bo.lazyredraw = true
      vim.bo.syntax = "off"
      vim.cmd("syntax off")
      vim.notify("Large file detected, optimizations applied", vim.log.levels.INFO)
    end
  end,
})

-- Optimize for very large files
vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("VeryLargeFileOptimizations", { clear = true }),
  callback = function()
    local size = vim.fn.getfsize(vim.fn.expand("%:p"))
    if size > 5 * 1024 * 1024 then -- 5MB
      vim.bo.swapfile = false
      vim.bo.undofile = false
      vim.bo.buftype = "nowrite"
      vim.bo.bufhidden = "unload"
      vim.bo.undolevels = -1
      vim.notify("Very large file detected, heavy optimizations applied", vim.log.levels.WARN)
    end
  end,
})

-- Garbage collection optimization
local gc_count = 0
local last_gc_time = 0

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("SmartGC", { clear = true }),
  callback = function()
    local current_time = vim.loop.hrtime() / 1e9
    
    gc_count = gc_count + 1
    
    -- GC every 10 events or every 30 seconds
    if gc_count >= 10 or (current_time - last_gc_time) > 30 then
      collectgarbage("collect")
      collectgarbage("step", 1000)
      gc_count = 0
      last_gc_time = current_time
    end
  end,
})

-- Memory pressure monitoring
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("MemoryMonitor", { clear = true }),
  callback = function()
    local mem_kb = tonumber(vim.fn.system("ps -o rss= -p " .. vim.fn.getpid()):gsub("%s+", "")) or 0
    
    -- Force GC if memory usage is high (>500MB)
    if mem_kb > 500000 then
      collectgarbage("collect")
      vim.notify("High memory usage detected, forced garbage collection", vim.log.levels.WARN)
    end
  end,
})

-- Optimize syntax highlighting for performance
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("SyntaxOptimization", { clear = true }),
  callback = function()
    if vim.bo.filetype == "" then
      vim.cmd("syntax off")
    end
  end,
})

-- Performance monitoring command
vim.api.nvim_create_user_command("StartupTime", function()
  local start_time = vim.loop.hrtime()
  vim.defer_fn(function()
    local end_time = vim.loop.hrtime()
    local startup_ms = (end_time - start_time) / 1000000
    vim.notify(string.format("Startup time: %.2f ms", startup_ms))
  end, 100)
end, { desc = "Show startup time" })

-- Memory usage command
vim.api.nvim_create_user_command("Memory", function()
  local kb = vim.fn.system("ps -o rss= -p " .. vim.fn.getpid()):gsub("%s+", "")
  vim.notify(string.format("Memory usage: %s KB", kb))
end, { desc = "Show memory usage" })