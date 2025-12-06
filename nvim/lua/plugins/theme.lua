return {
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "vista", "neo-tree", "terminal", "trouble" },
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
      on_colors = function(colors) end,
      on_highlights = function(highlights, colors) end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.theme = "tokyonight"
      opts.options.component_separators = ""
      opts.options.section_separators = ""
      opts.options.globalstatus = true
      opts.options.disabled_filetypes = { "alpha", "dashboard" }
      
      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }
      
      return opts
    end,
    config = function(_, opts)
      require('lualine').setup(opts)
    end,
  },
}
