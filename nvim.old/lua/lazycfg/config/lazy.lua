local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  spec = {
    { 'LazyVim/LazyVim' },
    { import = 'lazycfg.plugins' },
  },
  change_detection = { notify = false },
  --  defaults = {
  --    lazy = false,
  --    version = false,
  --  },
  --  checker = { enabled = true },
  rtp = {
    disabled_plugins = {
      'gzip',
      'tarPlugin',
      'tohtml',
      'tutor',
      'zipPlugin',
    },
  },
})
