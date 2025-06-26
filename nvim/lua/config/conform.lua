-- formatters_by_ft = {

--   --
--   -- You can use a sub-list to tell conform to run *until* a formatter
--   -- is found.
--   javascript = { "prettier", stop_after_first = true },
--   typescript = { "prettier", stop_after_first = true },
-- },

require("conform").setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt", "goimports" },
    python = { "isort", "black", "ruff" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    graphql = { "prettierd", "prettier" },
    md = { "prettierd", "prettier" },
    txt = { "prettierd", "prettier" },
    handlebars = { "prettierd", "prettier" },
    hbs = { "prettierd", "prettier" },
  },
  formatters = {
    stylua = {
      args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
    },
    prettier = {
      require_cwd = true,
      cwd = require("conform.util").root_file({
        "package.json",
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.mjs",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
      }),
    },
  },
  -- Set up format-on-save
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    return {
      timeout_ms = 1500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      lsp_format = "never",
    }
  end,
})
