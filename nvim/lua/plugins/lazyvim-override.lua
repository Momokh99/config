-- Override LazyVim's default LSP configuration to prevent conflicts

return {
  -- Disable LazyVim's automatic mason setup
  { "LazyVim/LazyVim", opts = {
    -- Disable automatic LSP server installation
    lsp = {
      auto_install = false,
    },
  }},
}