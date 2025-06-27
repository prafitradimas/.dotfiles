vim.keymap.set(
  { "i", "n" },
  "<ESC>",
  "<ESC><CMD>noh<CR>",
  { desc = "Clear highlights" }
)

vim.keymap.set(
  "t",
  "<ESC>",
  "<C-\\><C-n>",
  { noremap = true, desc = "Close terminal" }
)

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex, { desc = "Open vim netrw" })

-- motion
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up" })

-- copy & paste clipboard
vim.keymap.set(
  { "n", "v" },
  "<leader>y",
  [["+y]],
  { desc = "Copy to clipboard" }
) -- copy
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" }) -- paste

-- adjust indents
vim.keymap.set("v", "<", "<gv", { desc = "Shift line left" })
vim.keymap.set("v", ">", ">gv", { desc = "Shift line right" })

-- Rename the variable under your cursor.
--  Most Language Servers support renaming across files, etc.
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })

-- Opens a popup that displays documentation about the word under your cursor
--  See `:help K` for why this keymap.
vim.keymap.set(
  "n",
  "K",
  vim.lsp.buf.hover,
  { desc = "LSP: Hover Documentation" }
)

require("keymap.diagnostic")
