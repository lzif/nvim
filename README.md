# My Neovim Configuration

A minimal Neovim configuration built from scratch, for modern development on Termux (Android). Leader is space.

## Installation

### For Termux (Android)

1. Install Neovim and Git:

   ```bash
   pkg install neovim git
   ```

2. Clone the repository:

   ```bash
   git clone https://github.com/lzif/nvim ~/.config/nvim
   ```

3. Run Neovim:

   ```bash
   nvim
   ```

Plugins install automatically on first launch via lazy.nvim.

## Prerequisites

- Neovim 0.11.5+
- Go toolchain, for gopls, gofmt, and goimports. Go must be installed at mason-install time, not only at runtime: mason builds gopls with the local `go` toolchain. Install goimports with `go install golang.org/x/tools/cmd/goimports@latest`.
- Rust toolchain, for rust_analyzer and rustfmt: `pkg install rust rust-analyzer` (rust includes rustfmt; there is no separate rustfmt package in Termux). rust_analyzer is deliberately NOT mason-managed: mason's rust-analyzer binary is glibc and cannot run on Termux (Bionic), Neovim fails to spawn it with "language server is either not installed, missing from PATH, or not executable". The config enables rust_analyzer only when the `rust-analyzer` binary is on PATH. Do NOT `:MasonInstall rust-analyzer`; if mason already installed a broken copy, remove it with `:MasonUninstall rust-analyzer`.
- make + a C compiler, for telescope-fzf-native.
- tree-sitter CLI >= 0.26.1, plus tar, curl, and a C compiler, for installing treesitter parsers. On Termux, install it with `pkg install tree-sitter` (0.27.2):
  ```bash
  pkg install tree-sitter
  tree-sitter --version
  ```
  Install it from Termux's own repo. Do NOT download the `tree-sitter-linux-arm64.gz` release from GitHub: that binary is built for glibc and cannot run on Termux (Bionic), it fails with "Check the interpreter or linker". The Termux package (0.27.2) is built for Bionic and works.
- biome, prettierd, and stylua, for conform formatting. Install them via your package manager or the mason registry (for example `:MasonInstall stylua prettierd biome`), or conform will notify on save when a formatter binary is missing.
- Node + the `typescript` package, for typescript-tools tsserver. Node is also an install-time requirement for emmet-language-server and svelte-language-server, which mason installs from npm.
- unzip + gzip, for mason package extraction.

## LSP servers

Installed via mason-lspconfig `ensure_installed`: emmet_language_server, svelte, lua_ls, gopls. rust_analyzer comes from the system package manager instead (see Prerequisites), not from mason. TypeScript is covered by typescript-tools.nvim, not by ts_ls, so no second TS server runs.

## Formatters

Conform, format on save with LSP fallback: JavaScript / TypeScript / TSX with biome then prettierd, Svelte and CSS with prettierd, JSON with biome, Lua with stylua, Go with goimports (falls back to gofmt if goimports is missing), Rust with rustfmt.

## File explorer

Oil.nvim. `<C-n>` or `<leader>e` toggles it on the current working directory. Edit like a buffer, save with `:w` to apply filesystem changes. Confirmation is kept on for simple edits.

## Keybindings

One table, generated from the actual keymaps. `<leader>` is space.

| Keybinding | Mode | Description |
|---|---|---|
| `<C-s>` | n, i | Save file |
| `<C-h>` | n | Clear search highlights |
| `<Tab>` | n | Next buffer |
| `<S-Tab>` | n | Previous buffer |
| `<C-x>` | n | Close buffer |
| `<C-q>` | n | Quit window |
| `<C-n>` | n | Toggle file explorer (oil) |
| `<leader>e` | n | Toggle file explorer (oil) |
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Find text |
| `<leader>fb` | n | Find buffers |
| `<leader>fh` | n | Find help |
| `<leader>fr` | n | Find recent files |
| `<leader>lf` | n | Format file (conform) |
| `<leader>li` | n | LSP info |
| `<leader>ls` | n | LSP restart |
| `<leader>gs` | n | Git status |
| `<leader>gb` | n | Toggle git blame |
| `<leader>gn` | n | Next git hunk |
| `<leader>gp` | n | Prev git hunk |
| `<leader>gh` | n | Preview hunk |
| `<leader>gr` | n | Reset hunk |
| `<leader>dd` | n | Show diagnostic |
| `<leader>dn` | n | Next diagnostic |
| `<leader>dp` | n | Prev diagnostic |
| `<leader>dl` | n | List diagnostics |
| `<leader>bd` | n | Delete buffer |
| `<leader>ba` | n | Delete all buffers except current |
| `<leader>w` | n | Save file |
| `<leader>q` | n | Quit |
| `<leader>x` | n | Save and quit |
| `<` | v | Indent left |
| `>` | v | Indent right |
| `<A-j>` | n | Move line down |
| `<A-k>` | n | Move line up |
| `<A-j>` | v | Move selection down |
| `<A-k>` | v | Move selection up |
| `gd` | n | Go to definition (LSP, buffer-local) |
| `gD` | n | Go to declaration (LSP, buffer-local) |
| `gi` | n | Go to implementation (LSP, buffer-local) |
| `gr` | n | Find references (LSP, buffer-local) |
| `K` | n | Hover (LSP, buffer-local) |
| `<leader>lr` | n | Rename symbol (LSP, buffer-local) |
| `<leader>la` | n | Code action (LSP, buffer-local) |

## Completion (nvim-cmp, insert mode)

| Keybinding | Description |
|---|---|
| `<Tab>` / `<S-Tab>` | Next / previous completion item, or trigger completion |
| `<Up>` / `<Down>` | Previous / next completion item |
| `<C-Space>` | Trigger completion |
| `<C-y>` | Confirm the selected item |
| `<CR>` | Confirm, without auto-selecting |
| `<C-e>` | Close the completion menu |
| `<C-u>` / `<C-d>` | Scroll the documentation window |
| `<C-f>` / `<C-b>` | Jump forward / backward in a snippet |

Note: `<C-n>` / `<C-p>` are not mapped for completion. In insert mode `<C-n>` falls through to Vim's builtin keyword completion, a second menu. Use `<Tab>` / `<S-Tab>` or `<Up>` / `<Down>` instead.

## Oil keys (inside the explorer)

Oil's own defaults apply, except `<C-s>` and `<C-h>`, which are disabled so the config's save and clear-highlights keys keep working. Useful oil keys: `<CR>` open, `-` go to parent directory, `g?` show all oil keys.

Notes:

- Modes: n is Normal mode, i is Insert mode, v is Visual mode.
- `<A-j>` / `<A-k>` often do not reach Neovim from phone keyboards, Alt rarely sends. They work from a real keyboard.
- Telescope is the fuzzy finder for files, text, buffers, and diagnostics.
- Diagnostics come from LSP, with virtual text off and a rounded floating window.
