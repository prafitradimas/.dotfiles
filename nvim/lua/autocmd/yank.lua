vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("yank-augroup", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
