return {
  -- ==============================================================================
  -- 🔧 C Development Tools
  -- ==============================================================================
  
  -- DAP (Debug Adapter Protocol) for C/C++
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- GDB adapter setup
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }
      
      -- C configuration
      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Attach to process",
          type = "gdb",
          request = "attach",
          processId = function()
            return vim.fn.input("Process ID: ")
          end,
          cwd = "${workspaceFolder}",
        },
      }
      
      -- C++ configuration
      dap.configurations.cpp = dap.configurations.c
      
      -- Setup DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })
      
      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- Keybindings for debugging
      vim.keymap.set("n", "<F5", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint with Condition" })
      vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
    end,
  },
  
  -- Code Runner for quick execution
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        mode = "term",
        focus = true,
        startinsert = true,
        term = {
          position = "below",
          size = 15,
        },
        filetype = {
          c = {
            cd = "cd $dir && ",
            cmd = "gcc -Wall -Wextra -g $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
          },
          cpp = {
            cd = "cd $dir && ",
            cmd = "g++ -Wall -Wextra -g $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
          },
        },
        project = {
          ["~/projects/c/*"] = {
            name = "C Project",
            description = "Run C project with Makefile",
            cd = "cd $dir && ",
            cmd = "make run",
          },
        },
      })
      
      -- Keybinding for code runner
      vim.keymap.set("n", "<leader>cr", ":RunCode<CR>", { desc = "Run code" })
      vim.keymap.set("n", "<leader>cf", ":RunFile<CR>", { desc = "Run file" })
      vim.keymap.set("n", "<leader>cp", ":RunProject<CR>", { desc = "Run project" })
    end,
  },
  
  -- Better C/C++ syntax highlighting
  {
    "bfrg/vim-cpp-modern",
    ft = { "c", "cpp", "h", "hpp" },
  },
  
  -- CMake integration
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        ctest_command = "ctest",
        cmake_regenerate_on_save = true,
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_build_directory = "build",
        cmake_soft_link_compile_commands = true,
        cmake_compile_commands_from_lsp = false,
        cmake_kits_path = nil,
        cmake_variants_message = {
          short = { show = true },
          long = { show = true, max_length = 40 },
        },
        cmake_dap_configuration = {
          name = "cpp",
          type = "codelldb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = true,
          console = "integratedTerminal",
        },
        cmake_executor = {
          name = "quickfix",
          opts = {},
          default_opts = {
            quickfix = {
              show = "always",
              position = "belowright",
              size = 10,
            },
            toggleterm = {
              direction = "float",
              close_on_exit = false,
              highlight = "Normal",
              name = "Terminal",
              float_opts = {
                border = "rounded",
              },
            },
          },
        },
        cmake_runner = {
          name = "terminal",
          opts = {},
          default_opts = {
            terminal = {
              name = "Terminal",
              prefix_name = "[CMakeTools] ",
              split_direction = "horizontal",
              split_size = 12,
              single_terminal_per_group = true,
              single_terminal_per_tab = true,
              keep_terminal_static_location = true,
              auto_close_when_success = true,
              auto_insert_when_success = false,
            },
          },
        },
        cmake_notifications = {
          enabled = true,
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          refresh_rate_ms = 100,
        },
        cmake_virtual_text_support = true,
      })
      
      -- CMake keybindings
      vim.keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", { desc = "CMake: Generate" })
      vim.keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "CMake: Build" })
      vim.keymap.set("n", "<leader>cr", "<cmd>CMakeRun<CR>", { desc = "CMake: Run" })
      vim.keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<CR>", { desc = "CMake: Debug" })
      vim.keymap.set("n", "<leader>cc", "<cmd>CMakeClean<CR>", { desc = "CMake: Clean" })
      vim.keymap.set("n", "<leader>ci", "<cmd>CMakeInstall<CR>", { desc = "CMake: Install" })
      vim.keymap.set("n", "<leader>co", "<cmd>CMakeOpen<CR>", { desc = "CMake: Open" })
      vim.keymap.set("n", "<leader>cs", "<cmd>CMakeStop<CR>", { desc = "CMake: Stop" })
    end,
  },
  
  -- Testing framework integration (disabled due to git issues)
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/neotest-c",
  --   },
  --   config = function()
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-c")({
  --           extra_args = { "-Wall", "-Wextra" },
  --         }),
  --       },
  --       discovery = {
  --         enabled = true,
  --         concurrent = 4,
  --       },
  --       running = {
  --         concurrent = true,
  --       },
  --       summary = {
  --         enabled = true,
  --         animated = true,
  --         follow = true,
  --         expand_errors = true,
  --         open = "botright split | resize 15",
  --         mappings = {
  --           attach = "a",
  --           expand = { "<CR>", "<2-LeftMouse>" },
  --           expand_all = "e",
  --           output = "o",
  --           short = "s",
  --           toggle = "t",
  --           clear_target = "u",
  --           clear_all = "U",
  --         },
  --       },
  --       output = {
  --         enabled = true,
  --         open_on_run = "short",
  --       },
  --       status = {
  --         enabled = true,
  --         virtual_text = true,
  --         signs = true,
  --       },
  --     })
  --     
  --     -- Neotest keybindings
  --     vim.keymap.set("n", "<leader>tt", function()
  --       require("neotest").run.run(vim.fn.expand("%"))
  --     end, { desc = "Test: Run file" })
  --     
  --     vim.keymap.set("n", "<leader>tn", function()
  --       require("neotest").run.run()
  --     end, { desc = "Test: Run nearest" })
  --     
  --     vim.keymap.set("n", "<leader>ts", function()
  --       require("neotest").summary.toggle()
  --     end, { desc = "Test: Summary" })
  --     
  --     vim.keymap.set("n", "<leader>to", function()
  --       require("neotest").output.open({ enter = true })
  --     end, { desc = "Test: Output" })
  --   end,
  -- },
}