return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({
        open_mapping = '<A-t>',
        direction = 'float',
      })
    end,
  },
}
