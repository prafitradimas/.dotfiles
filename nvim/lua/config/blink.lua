return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  build = vim.g.lazyvim_blink_main and "cargo build --release",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- add blink.compat to dependencies
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = {},
      version = not vim.g.lazyvim_blink_main and "*",
    },
  },
  event = "InsertEnter",

  --- @type blink.cmp.Config
  opts = {
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    snippets = {
      expand = function(snippet)
        return require("lazyvim.util").cmp.expand(snippet)
      end,
    },
    appearance = {
      nerd_font_variant = "mono",
      use_nvim_cmp_as_default = true,
    },
    sources = {
      compat = {},
      default = { "lsp", "path" },
    },
    completion = {
      ghost_text = { enabled = vim.g.ai_cmp },
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
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
      },
      menu = {
        auto_show = true,
        border = "single",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon

                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ =
                    require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                end

                return " " .. icon .. ctx.icon_gap .. " "
              end,

              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl =
                    require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
    },
    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        require("lazyvim.util").cmp.map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
    },
    cmdline = {
      enabled = false,
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    -- setup compat sources
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    -- add ai_accept to <Tab> key
    if not opts.keymap["<Tab>"] then
      if opts.keymap.preset == "super-tab" then -- super-tab
        opts.keymap["<Tab>"] = {
          require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
          require("lazyvim.util").cmp.map({ "snippet_forward", "ai_accept" }),
          "fallback",
        }
      else -- other presets
        opts.keymap["<Tab>"] = {
          require("lazyvim.util").cmp.map({ "snippet_forward", "ai_accept" }),
          "fallback",
        }
      end
    end

    -- Unset custom prop to pass blink.cmp validation
    opts.sources.compat = nil

    -- check if we need to override symbol kinds
    for _, provider in pairs(opts.sources.providers or {}) do
      ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
      if provider.kind then
        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        local kind_idx = #CompletionItemKind + 1

        CompletionItemKind[kind_idx] = provider.kind
        ---@diagnostic disable-next-line: no-unknown
        CompletionItemKind[provider.kind] = kind_idx

        ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
        local transform_items = provider.transform_items
        ---@param ctx blink.cmp.Context
        ---@param items blink.cmp.CompletionItem[]
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = kind_idx or item.kind
            item.kind_icon = require("lazyvim.util").config.icons.kinds[item.kind_name]
              or item.kind_icon
              or nil
          end
          return items
        end

        -- Unset custom prop to pass blink.cmp validation
        provider.kind = nil
      end
    end

    require("blink.cmp").setup(opts)
  end,
}
