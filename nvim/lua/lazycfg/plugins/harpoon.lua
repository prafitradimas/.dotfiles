return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          '<leader>ha',
          function()
            require('harpoon'):list():add()
          end,
          desc = 'Harpoon Add',
        },
        {
          '<leader>hl',
          function()
            local harpoon = require('harpoon')
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = 'Harpoon List',
        },
      }

      return keys
    end,
  },
}
