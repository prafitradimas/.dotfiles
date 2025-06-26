local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Give me rounded borders everywhere
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local function on_attach(client)
  client.server_capabilities.document_formatting = false
end

local servers = {
  vtsls = {
    capabilities = capabilities,
    filetypes = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnType = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
        },
      },
    },
  },
  gopls = {
    cmd = { "gopls" },
    capabilities = capabilities,
    settings = {
      gopls = {
        gofumpt = true,
        experimentalPostfixCompletions = true,
        codelenses = {
          gc_details = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          vendor = true,
          -- upgrade_dependency = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
          shadow = true,
        },
        staticcheck = true,
        usePlaceholders = true,
        completeUnimported = true,
        directoryFilters = {
          "-.git",
          "-.vscode",
          "-.idea",
          "-.vscode-test",
          "-node_modules",
        },
      },
    },
    init_options = {
      usePlaceholders = true,
    },
  },
  templ = {
    capabilities = capabilities,
    filetypes = { "templ" },
  },
  html = {
    capabilities = capabilities,
    filetypes = { "html", "templ" },
  },
  tailwindcss = {
    capabilities = capabilities,
    filetypes = { "templ", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
  },
  pyright = {
    capabilities = capabilities,
    filetypes = { "python" },
  },
  lua_ls = {
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
  intelephense = {
    capabilities = capabilities,
    filetypes = { "php", "blade" },
    settings = {
      intelephense = {
        filetypes = { "php", "blade" },
        files = {
          associations = { "*.php", "*.blade.php" },
          maxSize = 5000000,
        },
      },
    },
  },
}

require("mason").setup()
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua", -- Used to format Lua code

  -- ts
  "vtsls",

  -- go lang
  "gofumpt",
  "goimports",
  "gomodifytags",
  "impl",
  "delve",
  "templ",

  -- python
  "pyright",
  "black",
  "ruff",
  "mypy",

  "html",
  "tailwindcss",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend(
        "force",
        {},
        capabilities,
        server.capabilities or {}
      )
      server.on_attach = on_attach
      lspconfig[server_name].setup(server)
    end,
  },
})

require("autocmd.lsp")
