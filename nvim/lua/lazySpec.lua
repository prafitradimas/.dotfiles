_G.LazyVim = require("lazyvim.util")
LazyVim.config = require("lazyvim.config")

local function get_config(name)
  return function()
    require("config." .. name)
  end
end

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme("tokyonight-night")
      vim.cmd.hi("Comment gui=none")
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    -- For `nvim-treesitter` users.
    priority = 49,

    -- For blink.cmp's completion
    -- source
    -- dependencies = {
    --     "saghen/blink.cmp"
    -- },
    opts = {
      preview = {
        icon_provider = "devicons",
      },
    },
  },
  require("config.mason"),
  require("config.snacks"),
  require("config.harpoon"),
  require("config.neotree"),
  require("config.treesitter"),
  require("config.code-action"),
  require("config.which-key"),
  require("config.cmp"),
  require("config.gitsigns"),
  -- require("config.blink"),
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  { "tpope/vim-sleuth" },
  { "tpope/vim-fugitive" },
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = get_config("mini"),
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",

      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { "folke/neodev.nvim", opts = {} },
    },
    config = get_config("lsp"),
  },
  { -- Autoformat
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "[F]or[M]at buffer",
      },
    },
    config = get_config("conform"),
  },
  {
    "mrcjkb/rustaceanvim",
    version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
    ft = { "rust" },
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          completion = {
            crates = {
              enabled = true,
            },
          },
          lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
          },
        },
      },
    },
  },
}
