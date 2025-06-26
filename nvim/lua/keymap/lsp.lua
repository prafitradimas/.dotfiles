-- WARN: This is not Goto Definition, this is Goto Declaration.
--  For example, in C this would take you to the header.
vim.keymap.set(
  "n",
  "gD",
  vim.lsp.buf.declaration,
  { desc = "[G]oto [D]eclaration" }
)
vim.keymap.set(
  "n",
  "gd",
  require("fzf-lua").lsp_definitions,
  { desc = "[G]oto [D]efinition" }
)
vim.keymap.set(
  "n",
  "gr",
  require("fzf-lua").lsp_references,
  { desc = "[G]oto [R]eferences" }
)
vim.keymap.set(
  "n",
  "gI",
  require("fzf-lua").lsp_implementations,
  { desc = "[G]oto [I]mplementation" }
)

-- Jump to the type of the word under your cursor.
--  Useful when you're not sure what type a variable is and you want to see
--  the definition of its *type*, not where it was *defined*.
vim.keymap.set(
  "n",
  "<leader>D",
  require("fzf-lua").lsp_typedefs,
  { desc = "Type [D]efinition" }
)

-- Fuzzy find all the symbols in your current document.
--  Symbols are things like variables, functions, types, etc.
vim.keymap.set(
  "n",
  "<leader>ds",
  require("fzf-lua").lsp_document_symbols,
  { desc = "[D]ocument [S]ymbols" }
)

-- Fuzzy find all the symbols in your current workspace.
--  Similar to document symbols, except searches over your entire project.
vim.keymap.set(
  "n",
  "<leader>ws",
  require("fzf-lua").lsp_live_workspace_symbols,
  { desc = "[W]orkspace [S]ymbols" }
)

-- Rename the variable under your cursor.
--  Most Language Servers support renaming across files, etc.
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })

-- Execute a code action, usually your cursor needs to be on top of an error
-- or a suggestion from your LSP for this to activate.
vim.keymap.set(
  "n",
  "<leader>ca",
  require("fzf-lua").lsp_code_actions,
  { desc = "[C]ode [A]ction" }
)

-- Opens a popup that displays documentation about the word under your cursor
--  See `:help K` for why this keymap.
vim.keymap.set(
  "n",
  "K",
  vim.lsp.buf.hover,
  { desc = "LSP: Hover Documentation" }
)

vim.keymap.set(
  "i",
  "<C-h>",
  function() end,
  { buffer = true, desc = "LSP: [H]elp" }
)
