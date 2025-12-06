-- Keymaps are automatically loaded on VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ==============================================================================
-- 🔧 C Development Keybindings
-- ==============================================================================

-- Enhanced C file runner with terminal split
vim.keymap.set("n", "<leader>r", function()
  if vim.bo.filetype == "c" then
    print("Running C program...")
    vim.cmd("w")
    local file = vim.fn.expand("%:p")
    local output = vim.fn.expand("%:p:r")
    -- Compile first
    local result = os.execute("gcc -Wall -Wextra -g '" .. file .. "' -o '" .. output .. "'")
    if result == 0 then
      print("Compilation successful! Opening terminal...")
      -- Create vertical split and open terminal
      vim.cmd("vsplit")
      vim.cmd("terminal " .. output)
    else
      print("Compilation failed!")
    end
  else
    print("Not a C file! Current filetype: " .. vim.bo.filetype)
  end
end, { desc = "Run C program in terminal split" })

-- Close terminal split with <leader>x
vim.keymap.set("n", "<leader>x", function()
  if vim.bo.filetype == "terminal" then
    vim.cmd("bdelete!")
  else
    -- Try to close the current split
    vim.cmd("close")
  end
end, { desc = "Close terminal/split" })

-- Build C file (compile only)
vim.keymap.set("n", "<leader>b", function()
  if vim.bo.filetype == "c" then
    vim.cmd("w")
    local file = vim.fn.expand("%:p")
    local output = vim.fn.expand("%:p:r")
    vim.cmd("!gcc -Wall -Wextra -O2 " .. file .. " -o " .. output)
    print("Compiled: " .. output)
  else
    print("Not a C file!")
  end
end, { desc = "Build C program (release)" })

-- Debug C program with GDB
vim.keymap.set("n", "<leader>d", function()
  if vim.bo.filetype == "c" then
    vim.cmd("w")
    local file = vim.fn.expand("%:p")
    local output = vim.fn.expand("%:p:r")
    vim.cmd("!gcc -Wall -Wextra -g " .. file .. " -o " .. output)
    vim.cmd("split | terminal gdb " .. output)
  else
    print("Not a C file!")
  end
end, { desc = "Debug C program with GDB" })

-- Run with Valgrind for memory checking
vim.keymap.set("n", "<leader>m", function()
  if vim.bo.filetype == "c" then
    vim.cmd("w")
    local file = vim.fn.expand("%:p")
    local output = vim.fn.expand("%:p:r")
    vim.cmd("!gcc -Wall -Wextra -g " .. file .. " -o " .. output)
    vim.cmd("split | terminal valgrind --leak-check=full --show-leak-kinds=all " .. output)
  else
    print("Not a C file!")
  end
end, { desc = "Run C program with Valgrind" })

-- Makefile integration
vim.keymap.set("n", "<leader>mb", function()
  if vim.fn.filereadable("Makefile") == 1 then
    vim.cmd("split | terminal make")
  else
    print("No Makefile found!")
  end
end, { desc = "Run make" })

vim.keymap.set("n", "<leader>mc", function()
  if vim.fn.filereadable("Makefile") == 1 then
    vim.cmd("split | terminal make clean")
  else
    print("No Makefile found!")
  end
end, { desc = "Run make clean" })

-- CMake integration
vim.keymap.set("n", "<leader>cb", function()
  if vim.fn.isdirectory("build") == 0 then
    vim.cmd("!mkdir build")
  end
  vim.cmd("split | terminal cd build && cmake .. && make")
end, { desc = "CMake build" })

vim.keymap.set("n", "<leader>cc", function()
  if vim.fn.isdirectory("build") == 0 then
    vim.cmd("!mkdir build")
  end
  vim.cmd("split | terminal cd build && cmake .. && make clean")
end, { desc = "CMake clean build" })

-- Quick compile and run in terminal
vim.keymap.set("n", "<leader>q", function()
  if vim.bo.filetype == "c" then
    vim.cmd("w")
    local file = vim.fn.expand("%:p")
    local output = vim.fn.expand("%:p:r")
    vim.cmd("!gcc -Wall -Wextra -g " .. file .. " -o " .. output)
    vim.cmd("split | terminal " .. output)
  else
    print("Not a C file!")
  end
end, { desc = "Quick compile & run in terminal" })

-- Create C project template
vim.keymap.set("n", "<leader>cp", function()
  local project_name = vim.fn.input("Project name: ")
  if project_name ~= "" then
    vim.cmd("!mkdir " .. project_name)
    vim.cmd("cd " .. project_name)
    vim.cmd("!touch main.c Makefile README.md")
    -- Create basic main.c
    local main_c = io.open("main.c", "w")
    main_c:write([[
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("Hello, World!\n");
    return 0;
}
]])
    main_c:close()
    -- Create basic Makefile
    local makefile = io.open("Makefile", "w")
    makefile:write([[
CC = gcc
CFLAGS = -Wall -Wextra -g
TARGET = main
SRCS = main.c

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

clean:
	rm -f $(TARGET)

debug: CFLAGS += -DDEBUG
debug: $(TARGET)

.PHONY: all clean debug
]])
    makefile:close()
    -- Create README
    local readme = io.open("README.md", "w")
    readme:write("# " .. project_name .. "\n\nA C project.\n\n## Build\n\n```bash\nmake\n```\n\n## Run\n\n```bash\n./main\n```\n\n## Clean\n\n```bash\nmake clean\n```\n")
    readme:close()
    vim.cmd("edit main.c")
    print("Created C project: " .. project_name)
  end
end, { desc = "Create C project template" })

-- ==============================================================================
-- 🧭 Navigation & Movement
-- ==============================================================================

-- Enhanced navigation
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ==============================================================================
-- 🪟 Window Management
-- ==============================================================================

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- ==============================================================================
-- 💾 File Operations
-- ==============================================================================

-- Quick save and quit
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Terminal
vim.keymap.set("n", "<leader>t", "<cmd>terminal<CR>", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- File operations
vim.keymap.set("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New file" })
vim.keymap.set("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save file" })

-- ==============================================================================
-- 📋 Clipboard Operations
-- ==============================================================================

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- Paste from system clipboard
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], { desc = "Paste from clipboard" })

-- ==============================================================================
-- 📝 Text Editing
-- ==============================================================================

-- Move lines up/down
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Stay in indent mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in indent mode" })