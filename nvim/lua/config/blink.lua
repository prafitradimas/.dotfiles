local lazyVim = require("lazyvim.util")

require("blink.cmp").setup({
  snippets = {
    expand = function(snippet, _)
      return lazyVim.cmp.expand(snippet)
    end,
  },
  appearance = {
    nerd_font_mono = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    min_keyword_length = function()
      return vim.bo.filetype == "markdown" and 4 or 0
    end,
    providers = {
      lsp = {
        fallbacks = {},
      },
    },
  },
  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "single",
      },
    },
    menu = {
      border = "single",
      draw = {
        treesitter = { "lsp" },
      },
    },
    ghost_text = { enabled = vim.g.ai_cmp },
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        auto_insert = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
      },
    },
  },
  keymap = {
    preset = "enter",
    ["<Tab>"] = {
      lazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
      "fallback",
    },
  },
})
