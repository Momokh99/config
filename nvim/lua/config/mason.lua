-- Mason configuration for LSP server management

return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  opts = {
    ensure_installed = {
      -- Lua
      "lua_ls",
      "stylua",

      -- Python
      "pyright",
      "black",
      "isort",
      "ruff",

      -- C/C++
      "clangd",
      "clang-format",

      -- JavaScript/TypeScript
      "typescript-language-server",
      "prettier",
      "eslint-lsp",

      -- Web Development
      "html-lsp",
      "css-lsp",
      "json-lsp",
      "yaml-language-server",

      -- Shell
      "bash-language-server",
      "shellcheck",
      "shfmt",

      -- Go
      "gopls",
      "gofumpt",

      -- Rust
      "rust-analyzer",

      -- Git
      "gitui",
      "lazygit",

      -- Utilities
      "tree-sitter-cli",
      "codespell",
    },
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "rounded",
    },
    max_concurrent_installers = 4,
    log_level = vim.log.levels.INFO,
  },
  config = function(_, opts)
    -- Add Go GOPATH to PATH for nvim
    local gopath = vim.fn.trim(vim.fn.system("go env GOPATH 2>/dev/null || echo $HOME/go"))
    if gopath and gopath ~= "" then
      vim.env.PATH = gopath .. "/bin:" .. vim.env.PATH
    end
    
    require("mason").setup(opts)

    -- Auto-install missing servers with proper error handling
    local mr = require("mason-registry")
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local ok, p = pcall(mr.get_package, tool)
        if ok and p then
          if not p:is_installed() then
            p:install():on("closed", function()
              if p:is_installed() then
                vim.notify("Successfully installed " .. tool, vim.log.levels.INFO)
              end
            end)
          end
        else
          vim.notify("Package " .. tool .. " not found in mason registry", vim.log.levels.WARN)
        end
      end
    end

    -- Wait for registry to be ready before installing
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      vim.defer_fn(ensure_installed, 1000) -- Delay to allow registry to populate
    end
  end,
}