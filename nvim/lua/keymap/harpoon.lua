local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "[H]arpoon [A]dd" })

vim.keymap.set("n", "<leader>hl", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon [L]ist" })

for i = 1, 5 do
  vim.keymap.set("n", "<leader>h" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon to File " .. i })
end
