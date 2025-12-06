-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim will set most options, only add customizations here
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Stability enhancements
vim.opt.updatetime = 300 -- Faster update time for better responsiveness
vim.opt.timeoutlen = 500 -- Faster timeout for key mappings
vim.opt.ttimeoutlen = 50 -- Very fast timeout for escape sequences
-- vim.opt.lazyredraw = true -- Disabled for Noice compatibility (only used for large files)
vim.opt.synmaxcol = 200 -- Don't syntax highlight very long lines
vim.opt.swapfile = false -- Disable swap files for better stability