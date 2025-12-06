local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      
      opts.formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              nvim_lsp_signature_help = "[Signature]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        }),
      }
      
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ 
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          elseif require("luasnip").expand_or_locally_jumpable() then
            require("luasnip").expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      })
      
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "nvim_lsp_signature_help", priority = 900 },
        { name = "luasnip", priority = 750 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250, max_item_count = 10 },
      })
      
      opts.experimental = {
        ghost_text = true,
      }
      
      opts.completion = {
        completeopt = "menu,menuone,noinsert",
      }
      
      return opts
    end,
  },
  
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = function(_, opts)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
      
      opts.store_selection_keys = "<Tab>"
      opts.update_events = { "TextChanged", "TextChangedI" }
      opts.enable_autosnippets = true
      
      local ls = require("luasnip")
      
      ls.add_snippets("lua", {
        ls.snippet("req", {
          ls.text_node("local "),
          ls.insert_node(1, "module"),
          ls.text_node(" = require(\""),
          ls.insert_node(2, "module"),
          ls.text_node("\")"),
        }, {
          desc = "Require module",
        }),
        
        ls.snippet("func", {
          ls.text_node("function "),
          ls.insert_node(1, "name"),
          ls.text_node("("),
          ls.insert_node(2, "args"),
          ls.text_node(")"),
          ls.text_node({ "", "\t", "" }),
          ls.insert_node(3),
          ls.text_node({ "", "end" }),
        }, {
          desc = "Function definition",
        }),
        
        ls.snippet("local", {
          ls.text_node("local "),
          ls.insert_node(1, "name"),
          ls.text_node(" = "),
          ls.insert_node(2, "value"),
        }, {
          desc = "Local variable",
        }),
      })
      
      ls.add_snippets("python", {
        ls.snippet("def", {
          ls.text_node("def "),
          ls.insert_node(1, "function_name"),
          ls.text_node("("),
          ls.insert_node(2, "args"),
          ls.text_node("):"),
          ls.text_node({ "", "\t", "" }),
          ls.insert_node(3),
          ls.text_node({ "", "" }),
        }, {
          desc = "Function definition",
        }),
        
        ls.snippet("class", {
          ls.text_node("class "),
          ls.insert_node(1, "ClassName"),
          ls.text_node(":"),
          ls.text_node({ "", "\tdef __init__(self" }),
          ls.insert_node(2, ", args"),
          ls.text_node("):"),
          ls.text_node({ "", "\t\t", "" }),
          ls.insert_node(3),
          ls.text_node({ "", "" }),
        }, {
          desc = "Class definition",
        }),
        
        ls.snippet("ifmain", {
          ls.text_node("if __name__ == \"__main__\":"),
          ls.text_node({ "", "\t", "" }),
          ls.insert_node(1),
        }, {
          desc = "If __name__ == '__main__'",
        }),
      })
      
      return opts
    end,
  },
  
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
}