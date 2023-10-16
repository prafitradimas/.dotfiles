local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<CMD> TmuxNavigateLeft <CR>", "window left" },
    ["<C-j>"] = { "<CMD> TmuxNavigateDown <CR>", "window down" },
    ["<C-k>"] = { "<CMD> TmuxNavigateUp <CR>", "window up" },
    ["<C-l>"] = { "<CMD> TmuxNavigateRight <CR>", "window right" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<CMD> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debug sidebar",
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>cst"] = {
      "<CMD> GoTagAdd json <CR>",
      "Add json struct tags",
    },
  },
}

return M
