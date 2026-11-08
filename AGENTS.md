# Neovim Configuration Context

## Project Overview

This is a minimal Neovim configuration built from scratch with essential features for modern development workflows, targeting Termux on Android. The configuration uses lazy.nvim as the plugin manager and follows a modular approach with separate files for different aspects of the setup.

### Architecture and Structure

The configuration is organized into the following main components:

- `init.lua`: Main entry point. Sets `mapleader` / `maplocalleader` to space first, then loads settings, keymaps, lazy.
- `stylua.toml`: StyLua config, tabs, width 2, double quotes. All Lua files are formatted with it.
- `/lua/config/`: Contains core configuration files:
  - `settings.lua`: Basic Neovim options and settings
  - `keymaps.lua`: Keyboard mappings and shortcuts (global maps only; LSP maps live in the LspAttach autocmd)
  - `lazy.lua`: Plugin manager (lazy.nvim) setup
- `/lua/plugins/`: Individual plugin configurations as separate files
  - `init.lua`: Core plugins (colorscheme, autopairs, conform, comment, lazydev)
  - `cmp.lua`: Completion engine (nvim-cmp)
  - `gitsigns.lua`: Git integration
  - `lspconfig.lua`: Language Server Protocol configuration (Neovim 0.11 `vim.lsp.config` API)
  - `mason.lua`: Package manager for LSP servers
  - `oil.lua`: File explorer (oil.nvim)
  - `telescope.lua`: Fuzzy finder
  - `treesitter.lua`: Syntax highlighting and parsing (nvim-treesitter main branch API)
  - `typescript-tools.lua`: TypeScript-specific tools
  - `which-key.lua`: Key binding documentation

### Technologies Used

- **Neovim**: Version 0.11.5 (required for the lua configuration)
- **Plugin Manager**: lazy.nvim
- **Colorscheme**: Catppuccin (with Mocha flavor, setup before colorscheme loads)
- **Completion Engine**: nvim-cmp with LSP, snippet, buffer, and path sources
- **Treesitter**: For enhanced syntax highlighting, parsers installed explicitly via `install():wait()`
- **LSP**: Neovim's built-in LSP client with mason for server management
- **Formatters**: Conform.nvim with biome, prettierd, stylua, goimports/gofmt, rustfmt
- **Fuzzy Finder**: Telescope with fzf-native extension
- **File explorer**: oil.nvim, toggled on the working directory

## Key Features

### Core Functionality
- Modern LSP support with code completion, diagnostics, and formatting
- File detection and syntax highlighting for JavaScript, TypeScript, Go, Rust, Svelte, Lua, CSS, HTML, and more
- Git integration through gitsigns for showing line changes
- Auto-completion with snippets support
- Efficient file navigation and buffer management
- File explorer that edits the filesystem like a buffer

### Formatting
- Automatic formatting on save with conform.nvim
- Support for JavaScript/TypeScript with biome and prettierd
- Lua formatting with stylua
- Svelte and CSS formatting with prettierd
- Go formatting with goimports, falling back to gofmt
- Rust formatting with rustfmt

### Navigation & Search
- Telescope integration for fuzzy finding files, buffers, and text
- Oil.nvim for file browsing
- Custom keybindings for buffer navigation
- Window management with Neovim defaults

## Key Bindings

Leader is space. The full table lives in README.md, generated from the actual keymaps. Summary of the groups:

### General Shortcuts
- `<Tab>` / `<S-Tab>`: Next / previous buffer
- `<C-x>`: Close the current buffer
- `<C-s>`: Save the current file (normal and insert mode)
- `<C-q>`: Quit the current window
- `<C-h>`: Clear search highlights
- `<C-n>` / `<leader>e`: Toggle the file explorer (oil)
- Visual `<` / `>`: Indent left / right, keeping the selection

### File Navigation (Telescope)
- `<leader>ff`: Find files
- `<leader>fg`: Live grep (search text)
- `<leader>fb`: Find buffers
- `<leader>fh`: Find help tags
- `<leader>fr`: Find recent files

### LSP Functions (buffer-local, set on LspAttach)
- `gd`: Go to definition
- `gD`: Go to declaration
- `gi`: Go to implementation
- `gr`: Find references
- `K`: Show hover information
- `<leader>lr`: Rename symbol
- `<leader>la`: Code action

### Global LSP-adjacent
- `<leader>lf`: Format file (conform, not LSP)
- `<leader>li`: LSP info
- `<leader>ls`: Restart LSP

### Diagnostics
- `<leader>dd`: Show diagnostic
- `<leader>dn`: Next diagnostic
- `<leader>dp`: Previous diagnostic
- `<leader>dl`: List diagnostics

### Git Integration (Gitsigns + Telescope)
- `<leader>gs`: Git status (Telescope git_status)
- `<leader>gb`: Toggle git blame
- `<leader>gn`: Next git hunk
- `<leader>gp`: Previous git hunk
- `<leader>gh`: Preview hunk
- `<leader>gr`: Reset hunk (leader version; bare `gr` is LSP references)

### Buffers and windows
- `<leader>bd`: Delete buffer
- `<leader>ba`: Delete all buffers except current
- `<leader>w` / `<leader>q` / `<leader>x`: Save / quit / save and quit
- `<A-j>` / `<A-k>`: Move lines up/down in normal and visual mode (often does not reach Neovim from phone keyboards)

## Installation

1. Install Neovim (version 0.11.5+) and Git
2. Clone this repository to `~/.config/nvim`
3. Launch Neovim (`nvim`), which will automatically install lazy.nvim and all plugins

Prerequisites are listed in README.md: Go toolchain (needed at mason-install time for gopls), Rust toolchain, make + C compiler, tree-sitter CLI >= 0.26.1 + tar + curl, biome / prettierd / stylua, Node + typescript package, unzip + gzip. Rust_analyzer on Termux is unverified: mason may fail to resolve an asset on Bionic, see README.md.

## Development Conventions

- Modular configuration approach with separate files for each concern
- Consistent use of leader key for plugin-related functions
- Proper separation between core settings, keymaps, and plugin configurations
- Use of Treesitter for enhanced syntax highlighting
- LSP-first approach for language-specific features
- Consistent formatting with automatic application on save
- One owner per binding: global maps in keymaps.lua, LSP maps only in the LspAttach autocmd, oil maps only in oil.lua
- All Lua formatted with StyLua per stylua.toml

## Testing and Verification

Since this is a Neovim configuration rather than typical software, testing is done by:
1. Opening Neovim with the configuration
2. Verifying that plugins load correctly
3. Testing key bindings and functionality
4. Opening different file types to ensure proper language support
5. Headless checks: `nvim --headless` startup with no errors, `:checkhealth vim.lsp` (not `:checkhealth lspconfig`, which was removed), LSP attach on real fixtures (a Go file in a dir with go.mod, a Rust file in a Cargo project, a TS file in a project), oil toggle open/close, conform format on Go and Rust files, `stylua --check lua/`
