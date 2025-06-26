vim.keymap.set({ 'i', 'n' }, '<ESC>', '<ESC><CMD>noh<CR>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('n', '<leader>fe', vim.cmd.Ex)

-- motion
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- yank OS
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>er', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rro[R] messages' })
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uick[F]ix list' })
