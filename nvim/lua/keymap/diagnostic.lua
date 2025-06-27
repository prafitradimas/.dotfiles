vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next [D]iagnostic message" })

vim.keymap.set(
  "n",
  "<leader>qf",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uick[F]ix list" }
)
