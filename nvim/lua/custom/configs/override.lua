local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
    "go",
    "html",
    "css",
    "javascript",
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

return M
