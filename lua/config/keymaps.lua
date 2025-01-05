vim.keymap.set('n', '<Tab>', ':bnext<CR>')  -- Buffer berikutnya
vim.keymap.set('n', '<C-Space>', ':bd<CR>')  -- Close buffer
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')  -- Toggle file explorer
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>')  -- Cari file
vim.keymap.set('n', '<C-f>', ':Telescope live_grep<CR>')   -- Cari teks
vim.keymap.set('n', '<C-b>', ':Telescope buffers<CR>')     -- Cari buffer

vim.keymap.set('n', '<C-s>', ':w<CR>')  -- Save file
vim.keymap.set('n', '<C-q>', ':q<CR>')  -- Quit

vim.keymap.set('n', '<C-k>', function()
  vim.diagnostic.open_float({ scope = "b" })  -- Show diagnostic di posisi kursor pada buffer aktif
end)
vim.keymap.set('n', '<C-j>', function()
  vim.diagnostic.goto_prev()  -- Loncat ke diagnostic sebelumnya dalam buffer aktif
end)
vim.keymap.set('n', '<C-l>', function()
  vim.diagnostic.goto_next()  -- Loncat ke diagnostic berikutnya dalam buffer aktif
end)

vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a')  -- Save dan kembali ke insert

vim.keymap.set('n', '<C-h>', ':noh<CR>')  -- Clear highlight search
