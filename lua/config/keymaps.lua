local map = vim.keymap.set

map("n", "<C-s>", ":w<CR>", { desc = "Save file", silent = true })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file", silent = true })

map("n", "<C-h>", ":noh<CR>", { desc = "Clear search highlights", silent = true })

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
map("n", "<C-x>", ":bd<CR>", { desc = "Close buffer", silent = true })

map("n", "<C-q>", ":q<CR>", { desc = "Quit window", silent = true })

-- Find (Telescope)
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files", silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Find text", silent = true })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers", silent = true })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Find help", silent = true })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Find recent files", silent = true })

-- Format (conform, not LSP, so it works with no client attached)
map("n", "<leader>lf", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 5000 })
end, { desc = "Format" })
map("n", "<leader>li", ":LspInfo<CR>", { desc = "LSP info", silent = true })
map("n", "<leader>ls", ":LspRestart<CR>", { desc = "LSP restart", silent = true })

-- Git
map("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Git status", silent = true })
map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git blame", silent = true })
map("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { desc = "Next git hunk", silent = true })
map("n", "<leader>gp", ":Gitsigns prev_hunk<CR>", { desc = "Prev git hunk", silent = true })
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk", silent = true })
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk", silent = true })

-- Diagnostic (LSP errors)
map("n", "<leader>dd", function()
	vim.diagnostic.open_float({ scope = "b" })
end, { desc = "Show diagnostic" })
map("n", "<leader>dn", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "<leader>dp", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

map("n", "<leader>dl", ":Telescope diagnostics<CR>", { desc = "List diagnostics", silent = true })

map("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer", silent = true })
map("n", "<leader>ba", ":%bd|e#|bd#<CR>", { desc = "Delete all buffers except current", silent = true })

map("n", "<leader>w", ":w<CR>", { desc = "Save file", silent = true })
map("n", "<leader>q", ":q<CR>", { desc = "Quit", silent = true })
map("n", "<leader>x", ":x<CR>", { desc = "Save and quit", silent = true })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Note: <A-j> / <A-k> often do not reach Neovim from phone keyboards,
-- Alt rarely sends. Kept as-is, they work from a real keyboard.
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
