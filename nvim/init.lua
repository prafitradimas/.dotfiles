local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- You will need to install language servers `npm i -g vscode-langservers-extracted` and `npm install -g typescript typescript-language-server`
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim" },
    { import = "lazySpec" },
  },
  change_detection = { notify = false },
  --  defaults = {
  --    lazy = false,
  --    version = false,
  --  },
  --  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "single",
  },
})

require("option")
require("keymap.all")
-- require("setup.spelling")
