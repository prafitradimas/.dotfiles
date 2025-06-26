return {
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      build = ':Copilot auth',
      event = 'InsertEnter',
      opts = {
        suggestion = {
          enabled = false,
        },
        panel = { enabled = false },
        filetypes = {
          javascript = true,
          typescript = true,
          markdown = true,
          help = true,
        },
      },
    },
    config = function()
      local cmp = require('copilot_cmp')
      require('lazyvim.util.lsp').on_attach(function()
        cmp._on_insert_enter({})
      end)
    end,
  },
}
