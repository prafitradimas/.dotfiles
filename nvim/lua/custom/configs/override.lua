local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
    "go",
    "html",
    "css",
    "javascript",
    "typescript",
    "markdown",
    "markdown_inline",
    "bash",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
}

M.mason = {
  ensure_installed = {
    "lua-language-server",
    "stylua",
    "css-lsp",
    "html-lsp",
    "prettier",
    "gopls",
    "go-debug-adapter",
    "gofumpt",
    "goimports-reviser",
    "golines",
    "gomodifytags",
  },
}

M.telescope = {
  n = {
    ["<leader>fb"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
  },
}

return M
