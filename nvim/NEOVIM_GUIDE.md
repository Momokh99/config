# Neovim Complete Guide

## 🚀 Essential Commands

### File Operations
```vim
:w                    # Save file
:q                    # Quit
:wq                   # Save and quit
:q!                   # Quit without saving
:e filename           # Open file
:saveas filename      # Save as new filename
```

### Navigation
```vim
h j k l               # Left, Down, Up, Right
w b                   # Next/Previous word
0 $                   # Start/End of line
gg G                  # Start/End of file
Ctrl-f Ctrl-b         # Page down/up
:line_number          # Go to line
```

### Search & Replace
```vim
/pattern              # Search forward
?pattern              # Search backward
n N                   # Next/Previous match
:%s/old/new/g         # Replace all in file
:%s/old/new/gc        # Replace with confirmation
```

## 🎯 Your Custom Keybindings

### Leader Key (Space)
```vim
<leader>r             # Run C program
<leader>w             # Save file
<leader>q             # Quit
<leader>Q             # Quit all
<leader>h             # Clear highlights
<leader>t             # Open terminal
<leader>ff            # Find files (Telescope)
<leader>fg            # Live grep
<leader>fb            # Find buffers
```

### Window Management
```vim
<leader>sv            # Split vertical
<leader>sh            # Split horizontal
<leader>se            # Equalize splits
<leader>sx            # Close split
```

### Buffer Navigation
```vim
<Tab>                 # Next buffer
<S-Tab>               # Previous buffer
```

### Quick Fix
```vim
<leader>co            # Open quickfix
<leader>cc            # Close quickfix
<leader>cn            # Next quickfix
<leader>cp            # Previous quickfix
```

### Clipboard
```vim
<leader>y             # Yank to clipboard
<leader>Y             # Yank line to clipboard
<leader>p             # Paste from clipboard
```

### Line Movement
```vim
Alt-j                 # Move line down
Alt-k                 # Move line up
```

## 🔧 LSP (Language Server Protocol)

### Navigation
```vim
gd                    # Go to definition
gD                    # Go to declaration
gr                    # Go to references
gi                    # Go to implementation
```

### Information
```vim
K                     # Hover documentation
Ctrl-k                # Signature help
```

### Actions
```vim
<leader>rn            # Rename symbol
<leader>ca            # Code actions
```

### Diagnostics
```vim
<leader>e             # Open diagnostic float
[d ]d                 # Previous/Next diagnostic
```

## 🧩 Completion System

### Navigation
```vim
Tab                   # Next completion/snippet
S-Tab                 # Previous completion/snippet
Ctrl-j                # Next completion item
Ctrl-k                # Previous completion item
Ctrl-l                # Next snippet placeholder
Ctrl-h                # Previous snippet placeholder
```

### Triggers
- Completion appears automatically in insert mode
- `Ctrl-Space` to manually trigger completion
- `Ctrl-e` to abort completion

## 🌳 Treesitter Text Objects

### Selection
```vim
af                    # Select function outer
if                    # Select function inner
ac                    # Select class outer
ic                    # Select class inner
al                    # Select loop outer
il                    # Select loop inner
```

### Movement
```vim
]m [m                 # Next/Previous function start
]M [M                 # Next/Previous function end
]] [[                 # Next/Previous class start
][ []                 # Next/Previous class end
```

## 🔍 Telescope (Fuzzy Finder)

### Built-in Pickers
```vim
:Telescope find_files # Find files
:Telescope live_grep  # Search in files
:Telescope buffers    # Open buffers
:Telescope help_tags  # Help tags
:Telescope oldfiles   # Recent files
```

## 🎨 Visual Features

### Status Line
- Shows current mode, file info, git status, LSP status
- Located at bottom of screen

### Treesitter Context
- Shows current function/class at top
- Helps with navigation in large files

### Syntax Highlighting
- Powered by Treesitter for accurate coloring
- Supports 20+ languages

## 🛠️ Custom Commands

### Performance & Health
```vim
:StartupTime          # Show startup time
:Memory               # Show memory usage
:Profile start        # Start profiling
:Profile stop         # Stop profiling
:HealthCheck          # Run configuration health check
```

### Configuration
```vim
:BackupConfig         # Backup your configuration
```

## 🔌 Complete Plugin Guide

### 📦 Package Manager
#### **Lazy.nvim**
- **Purpose**: Modern plugin manager for Neovim
- **Features**: Fast startup, lazy loading, dependency management
- **Location**: Core package manager
- **Commands**: `:Lazy` (UI), `:Lazy sync`, `:Lazy install`, `:Lazy update`

### 🎨 Theme & Appearance
#### **Tokyo Night**
- **Purpose**: Beautiful dark theme with multiple variants
- **Features**: Support for multiple plugins, transparent background option
- **Variants**: storm, night, day
- **Customization**: Customizable colors and transparency

### 🧠 Language Support & Intelligence
#### **nvim-treesitter**
- **Purpose**: Advanced syntax highlighting and code understanding
- **Features**: Accurate syntax highlighting, code folding, incremental selection
- **Languages**: 20+ languages (Lua, Python, C, JavaScript, etc.)
- **Text Objects**: Function/class selection (`af`, `if`, `ac`, `ic`)
- **Movement**: Smart navigation between code blocks

#### **nvim-treesitter-context**
- **Purpose**: Shows current function/class context at top of screen
- **Features**: Contextual awareness, helps navigation in large files
- **Display**: Current scope information while scrolling

#### **nvim-lspconfig**
- **Purpose**: Language Server Protocol configuration
- **Features**: Code completion, diagnostics, goto definition, refactoring
- **Supported Languages**: Lua (lua_ls), Python (pyright), C/C++ (clangd), JavaScript/TypeScript (tsserver), and more
- **Integration**: Works with completion system and diagnostics

#### **mason.nvim**
- **Purpose**: Portable LSP server management
- **Features**: Easy installation of LSP servers, formatters, linters
- **GUI**: `:Mason` command for visual server management
- **Auto-install**: Automatically installs required servers

#### **mason-lspconfig.nvim**
- **Purpose**: Bridge between Mason and nvim-lspconfig
- **Features**: Automatic LSP server setup, ensures servers are installed
- **Integration**: Seamlessly connects Mason-installed servers with LSP config

### 🔍 Fuzzy Finding & Navigation
#### **telescope.nvim**
- **Purpose**: Powerful fuzzy finder for everything
- **Features**: File finding, live grep, buffer switching, help tags
- **Keybindings**: `<leader>ff` (files), `<leader>fg` (grep), `<leader>fb` (buffers)
- **Extensions**: Highly extensible with many pickers

#### **plenary.nvim**
- **Purpose**: Utility library for Neovim plugins
- **Features**: Async functions, file operations, data structures
- **Dependency**: Required by Telescope and many other plugins

#### **nvim-web-devicons**
- **Purpose**: File type icons for various UI elements
- **Features**: VS Code-like icons, supports hundreds of file types
- **Integration**: Used by Telescope, nvim-tree, and other UI plugins

### 🧩 Code Completion
#### **nvim-cmp**
- **Purpose**: Modern completion engine
- **Features**: LSP completion, snippet integration, buffer completion
- **Sources**: Multiple completion sources with priority system
- **UI**: Bordered windows, ghost text preview

#### **cmp-nvim-lsp**
- **Purpose**: LSP completion source for nvim-cmp
- **Features**: Intelligent code suggestions from language servers
- **Integration**: Provides LSP-based completions

#### **cmp-buffer**
- **Purpose**: Buffer completion source
- **Features**: Complete from words in current buffer
- **Performance**: Fast and lightweight

#### **cmp-path**
- **Purpose**: File path completion
- **Features**: Intelligent file path suggestions
- **Context**: Works in insert mode for file operations

#### **cmp-cmdline**
- **Purpose**: Command line completion
- **Features**: Auto-completion for Vim commands and searches
- **Integration**: Enhances `:` and `/` command modes

#### **LuaSnip**
- **Purpose**: Powerful snippet engine
- **Features**: VS Code-style snippets, custom snippet creation
- **Navigation**: Tab through placeholders, jump between positions
- **Custom Snippets**: Pre-configured Lua and Python templates

#### **cmp_luasnip**
- **Purpose**: Snippet completion source
- **Features**: Suggest snippets while typing
- **Integration**: Works with nvim-cmp

#### **friendly-snippets**
- **Purpose**: Large collection of pre-made snippets
- **Features**: Snippets for 50+ languages and frameworks
- **Languages**: Python, JavaScript, React, Vue, Go, Rust, etc.

#### **lspkind.nvim**
- **Purpose**: VS Code-like pictograms for completion
- **Features**: Icons for different completion types (function, variable, etc.)
- **Visual**: Makes completion menu more informative

### ✏️ Text Editing & Enhancement
#### **nvim-autopairs**
- **Purpose**: Automatic bracket and quote pairing
- **Features**: Smart pairing, Treesitter integration
- **Pairs**: (), [], {}, "", '', ``, etc.

#### **nvim-surround**
- **Purpose**: Add/change/delete surrounding characters
- **Features**: `ys"` (surround with quotes), `ds"` (delete quotes), `cs"'` (change quotes to double quotes)
- **Powerful**: Works with any surrounding characters

#### **Comment.nvim**
- **Purpose**: Smart commenting plugin
- **Features**: `gcc` (comment line), `gc` (comment motion), `gb` (comment block)
- **Language-aware**: Respects different comment styles per language

#### **nvim-visual-multi**
- **Purpose**: Multiple cursors like Sublime Text/VS Code
- **Features**: Multi-cursor editing, column/word selection
- **Commands**: `Ctrl-n` to add cursor, `Ctrl-q` for column mode

#### **indent-blankline.nvim**
- **Purpose**: Visual indentation guides
- **Features**: Vertical lines showing indentation levels
- **Customization**: Configurable colors and styles

### 📁 File Management
#### **nvim-tree.lua**
- **Purpose**: File explorer sidebar
- **Features**: Tree view, git integration, file operations
- **Keybindings**: `<leader>e` to toggle, navigation with hjkl
- **Git Icons**: Shows git status for files

### 🔧 Git Integration
#### **gitsigns.nvim**
- **Purpose**: Git signs in gutter
- **Features**: Line changes, blame, hunk operations
- **Signs**: + (added), ~ (modified), - (removed)
- **Commands**: `:Gitsigns preview_hunk`, `:Gitsigns reset_hunk`

#### **vim-fugitive**
- **Purpose**: Git commands inside Vim
- **Features**: `:Git` command, git status, commit, push
- **Integration**: Seamless git workflow

#### **diffview.nvim**
- **Purpose**: Git diff viewer
- **Features**: Side-by-side diffs, merge conflict resolution
- **Commands**: `:DiffviewOpen`, `:DiffviewClose`

### 🎯 Navigation & Productivity
#### **which-key.nvim**
- **Purpose**: Available keybinding popup
- **Features**: Shows available commands after leader key
- **Helpful**: Discover keybindings and their descriptions

#### **harpoon**
- **Purpose**: Quick file navigation
- **Features**: Bookmark files, quick switching between projects
- **Commands**: `<leader>a` (add file), `<C-h>`/`<C-t>` (navigate)

#### **flash.nvim**
- **Purpose**: Quick navigation plugin
- **Features**: `s` for character-based jumping, `S` for Treesitter-aware jumping
- **Speed**: Fast navigation to any location

### 🎨 UI Enhancement
#### **lualine.nvim**
- **Purpose**: Status line replacement
- **Features**: Mode, file info, git status, LSP status, location
- **Customizable**: Themes, components, sections

#### **nvim-notify**
- **Purpose**: Modern notification system
- **Features**: Styled notifications, different levels (info, warn, error)
- **Integration**: Used by plugins for better user feedback

#### **dressing.nvim**
- **Purpose**: Better UI for input/select
- **Features**: Modern interfaces for `input()`, `confirm()`, `vim.ui.select`
- **Visual**: Improves default Vim UI elements

#### **fidget.nvim**
- **Purpose**: LSP progress indicator
- **Features**: Shows LSP server progress in status line
- **Visual**: Spinner and progress information

### 🔍 Search & Replace
#### **nvim-spectre**
- **Purpose**: Advanced search and replace
- **Features**: Project-wide search/replace, regex support
- **Interface**: Visual search results with preview

#### **todo-comments.nvim**
- **Purpose**: Highlight TODO comments
- **Features**: Highlights TODO, FIXME, NOTE, etc.
- **Navigation**: Jump between todos with `]t` `[t`

### 🕐 Time & History
#### **undotree**
- **Purpose**: Visual undo history
- **Features**: Tree view of undo history, time travel
- **Commands**: `:UndotreeToggle`

### 🎮 Learning & Practice
#### **vim-be-good**
- **Purpose**: Vim game for practice
- **Features**: Interactive lessons, speed training
- **Commands**: `:VimBeGood`

### 🛠️ Quality of Life
#### **trouble.nvim**
- **Purpose**: Better diagnostics display
- **Features**: List of diagnostics, quickfix, location list
- **Navigation**: Jump between issues easily

## 📁 File Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/
│   │   ├── options.lua     # Editor settings
│   │   ├── keymaps.lua     # Custom keybindings
│   │   ├── autocmds.lua    # Auto commands
│   │   ├── lazy.lua        # Package manager setup
│   │   ├── performance.lua # Performance monitoring
│   │   └── stability.lua   # Error handling
│   └── plugins/
│       ├── completion.lua   # Completion setup
│       ├── lsp.lua         # LSP configuration
│       ├── myplugins.lua   # Your plugins
│       ├── theme.lua       # Colorscheme
│       └── text.lua        # Text editing plugins
├── plugin/
│   └── after/
│       └── transparency.lua # Transparency settings
└── NEOVIM_GUIDE.md         # This file
```

## 🎯 Modes

### Normal Mode (Esc)
- Navigation, commands, text manipulation
- Default mode when not editing

### Insert Mode (i, a, o)
- Text editing
- Completion and snippets active

### Visual Mode (v, V, Ctrl-v)
- Text selection
- Can operate on selected text

### Command Mode (:)
- Ex commands
- File operations, settings

### Terminal Mode (t)
- Terminal integration
- Use `Esc` to exit

## 🚀 Productivity Tips

### 1. Fast Navigation
- Use `gd` for quick definition jumps
- `Ctrl-o`/`Ctrl-i` to jump back/forward
- `:marks` to see all marks

### 2. Efficient Editing
- Use text objects (`ciw` change inner word)
- Multiple cursors with vim-visual-multi
- Auto-pairs for brackets/quotes

### 3. Search & Replace
- Use `*` to search word under cursor
- `%` for matching brackets
- `:g/pattern/d` to delete matching lines

### 4. Buffer Management
- `:ls` to list all buffers
- `:bd` to delete buffer
- `:ba` to show all buffers

### 5. Window Management
- `Ctrl-w h/j/k/l` to navigate windows
- `Ctrl-w =` to equalize windows
- `Ctrl-w +/-` to resize windows

## 🔧 Configuration Customization

### Adding New Plugins
Edit `lua/plugins/myplugins.lua`:
```lua
{
  "username/plugin-name",
  event = "VeryLazy",  -- When to load
  opts = {},           -- Plugin options
}
```

### Adding Keybindings
Edit `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>x", "<cmd>Command<CR>", { desc = "Description" })
```

### Changing Options
Edit `lua/config/options.lua`:
```lua
vim.opt.option_name = value
```

## 🎨 Themes & Colors

### Current Theme
- Tokyo Night (configured in `lua/plugins/theme.lua`)
- Supports transparency
- Customizable colors

### Changing Theme
Replace `"folke/tokyonight.nvim"` with your preferred theme in `myplugins.lua`.

## 🐛 Troubleshooting

### Common Issues
1. **LSP not working**: Run `:Mason` to install language servers
2. **Completion not showing**: Check `:HealthCheck`
3. **Slow startup**: Run `:StartupTime` to identify bottlenecks
4. **Plugin errors**: Check `:messages` for error details

### Recovery Commands
```vim
:Lazy sync             # Update plugins
:Mason                 # Install LSP servers
:TSInstall             # Install Treesitter parsers
:checkhealth           # Neovim health check
```

## 📚 Learning Resources

### Built-in Help
```vim
:help                  # General help
:help topic            # Specific topic
:helpgrep pattern      # Search help
```

### Practice
```vim
:VimBeGood             # Vim game (installed)
: Tutor                # Built-in tutorial
```

---

## 🐍 Python Development Guide

### 🛠️ Python LSP Setup
Your configuration includes **pyright** for Python development:

#### **Installation**
```bash
# Install Python LSP server (auto-installed by Mason)
:Mason
# Look for "pyright" and install if not present
```

#### **Python Features Available**
- **Code completion**: Intelligent suggestions for Python code
- **Type checking**: Static type analysis with pyright
- **Go to definition**: `gd` on functions/classes
- **Documentation**: `K` for function/class documentation
- **Refactoring**: `<leader>rn` for rename, `<leader>ca` for code actions
- **Diagnostics**: Real-time error checking and warnings

#### **Python Keybindings**
```vim
gd                    # Go to function/class definition
gr                    # Find all references
K                     # Show documentation
<leader>rn            # Rename variable/function
<leader>ca            # Code actions (import, fix issues)
```

#### **Python Snippets**
Type these and press `Tab` to expand:
```python
def                  # Function template
class                # Class template
```

#### **Python Workflow**
1. Open Python file: `nvim script.py`
2. LSP auto-activates for `.py` files
3. Start typing - completion appears automatically
4. Use `Tab` to accept completions
5. Use `gd` to jump to definitions
6. Use `K` for documentation

#### **Running Python Code**
```vim
# Method 1: Terminal
<leader>t            # Open terminal
python script.py     # Run in terminal

# Method 2: Quick command
:!python %           # Run current file
```

#### **Python Project Structure**
```
my_project/
├── main.py
├── utils.py
├── requirements.txt
└── .gitignore
```

#### **Virtual Environments**
```bash
# Create virtual environment
python -m venv venv

# Activate
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows

# Install packages
pip install -r requirements.txt
```

---

## 🔧 C/C++ Development Guide

### 🛠️ C/C++ LSP Setup
Your configuration includes **clangd** for C/C++ development:

#### **Installation**
```bash
# Install C/C++ LSP server (auto-installed by Mason)
:Mason
# Look for "clangd" and install if not present
```

#### **C/C++ Features Available**
- **Code completion**: Intelligent suggestions for C/C++ code
- **Syntax checking**: Real-time error detection
- **Go to definition**: `gd` on functions/variables
- **Documentation**: `K` for function documentation
- **Refactoring**: `<leader>rn` for rename, `<leader>ca` for code actions
- **Build integration**: Works with Makefiles and CMake

#### **C/C++ Keybindings**
```vim
gd                    # Go to function/variable definition
gr                    # Find all references
K                     # Show documentation
<leader>rn            # Rename variable/function
<leader>ca            # Code actions (fix includes, etc.)
<leader>r             # Run C program (custom keybinding)
```

#### **Running C Code**
Your custom keybinding for C programs:
```vim
<leader>r             # Compile and run current C file
```

This command:
1. Saves the current file
2. Compiles: `gcc filename.c -o filename`
3. Executes the compiled program

#### **Manual Compilation**
```vim
# Compile C file
:!gcc % -o %:r        # Compile current file
:!gcc program.c -o program

# Compile C++ file
:!g++ % -o %:r        # Compile current C++ file
:!g++ program.cpp -o program

# Run compiled program
:!./%:r               # Run compiled program
:!./program
```

#### **C/C++ Project Structure**
```
my_c_project/
├── main.c
├── utils.c
├── utils.h
├── Makefile
└── .gitignore
```

#### **Sample Makefile**
```makefile
CC = gcc
CFLAGS = -Wall -g
TARGET = program
SRCS = main.c utils.c
OBJS = $(SRCS:.c=.o)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)
```

#### **Build Commands**
```vim
:!make                # Build with Makefile
:!make clean          # Clean build files
```

---

## 🎓 Learning Path for Beginners

### 🐍 Python Learning Path

#### **Week 1: Basics**
```python
# Variables and Data Types
name = "John"
age = 25
height = 5.9
is_student = True

# Basic Operations
print("Hello, " + name)
print(f"{name} is {age} years old")

# Lists and Loops
fruits = ["apple", "banana", "orange"]
for fruit in fruits:
    print(f"I like {fruit}")
```

#### **Week 2: Functions and Control Flow**
```python
def greet(name, age):
    if age >= 18:
        return f"Hello {name}, you're an adult!"
    else:
        return f"Hello {name}, you're young!"

# Function call
message = greet("Alice", 20)
print(message)

# List comprehension
numbers = [1, 2, 3, 4, 5]
squares = [x**2 for x in numbers]
print(squares)  # [1, 4, 9, 16, 25]
```

#### **Week 3: Data Structures**
```python
# Dictionaries
person = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

# Classes
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def greet(self):
        return f"Hi, I'm {self.name} and I'm {self.age}"

john = Person("John", 30)
print(john.greet())
```

#### **Week 4: File I/O and Modules**
```python
# Reading files
with open("data.txt", "r") as file:
    content = file.read()
    print(content)

# Writing files
with open("output.txt", "w") as file:
    file.write("Hello, World!")

# Importing modules
import math
import random

print(math.sqrt(16))  # 4.0
print(random.randint(1, 10))  # Random number 1-10
```

### 🔧 C Learning Path

#### **Week 1: Basic Syntax**
```c
#include <stdio.h>

int main() {
    // Variables and basic types
    int age = 25;
    float height = 5.9;
    char name[] = "John";
    
    // Output
    printf("Name: %s, Age: %d, Height: %.1f\n", name, age, height);
    
    return 0;
}
```

#### **Week 2: Control Flow and Loops**
```c
#include <stdio.h>

int main() {
    // If-else
    int score = 85;
    if (score >= 90) {
        printf("Grade: A\n");
    } else if (score >= 80) {
        printf("Grade: B\n");
    } else {
        printf("Grade: C\n");
    }
    
    // For loop
    for (int i = 1; i <= 5; i++) {
        printf("Count: %d\n", i);
    }
    
    return 0;
}
```

#### **Week 3: Functions and Arrays**
```c
#include <stdio.h>

// Function declaration
int add(int a, int b);
void print_array(int arr[], int size);

int main() {
    // Arrays
    int numbers[] = {1, 2, 3, 4, 5};
    int size = sizeof(numbers) / sizeof(numbers[0]);
    
    // Function call
    int result = add(10, 20);
    printf("Sum: %d\n", result);
    
    print_array(numbers, size);
    
    return 0;
}

// Function definition
int add(int a, int b) {
    return a + b;
}

void print_array(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}
```

#### **Week 4: Pointers and Memory**
```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    // Pointers
    int number = 42;
    int *ptr = &number;
    
    printf("Value: %d\n", number);
    printf("Address: %p\n", &number);
    printf("Pointer value: %d\n", *ptr);
    
    // Dynamic memory allocation
    int *dynamic_array = (int*)malloc(5 * sizeof(int));
    if (dynamic_array != NULL) {
        for (int i = 0; i < 5; i++) {
            dynamic_array[i] = i * 10;
        }
        
        for (int i = 0; i < 5; i++) {
            printf("%d ", dynamic_array[i]);
        }
        
        free(dynamic_array);  // Don't forget to free!
    }
    
    return 0;
}
```

---

## 🎯 Quick Reference Card

### Essential Daily Commands
- `:w` - Save | `:q` - Quit | `:wq` - Save & Quit
- `gd` - Go to definition | `K` - Documentation
- `<leader>ff` - Find files | `<leader>fg` - Search
- `Tab` - Next completion | `S-Tab` - Previous
- `<leader>w` - Save | `<leader>q` - Quit

### Mode Switching
- `Esc` - Normal mode | `i` - Insert | `v` - Visual | `:` - Command

### Your Custom Leader Commands
- `<leader>r` - Run C code
- `<leader>t` - Terminal
- `<leader>h` - Clear search highlights
- `<leader>y` - Copy to clipboard

### Language-Specific Commands
- **Python**: `:!python %` - Run current file
- **C**: `<leader>r` - Compile and run current file
- **Both**: `gd` - Go to definition, `K` - Documentation

This guide covers everything you need to use your optimized Neovim configuration effectively for general use, Python, and C/C++ development!