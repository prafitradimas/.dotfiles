local fzf = require("fzf-lua")

local attach_augroup =
  vim.api.nvim_create_augroup("lsp-augroup-attach", { clear = true })
local detach_augroup =
  vim.api.nvim_create_augroup("lsp-augroup-detach", { clear = true })
local highlight_augroup =
  vim.api.nvim_create_augroup("lsp-augroup-highlight", { clear = false })

vim.api.nvim_create_autocmd("LspAttach", {
  group = attach_augroup,
  callback = function(event)
    -- Create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc)
      vim.keymap.set(
        "n",
        keys,
        func,
        { buffer = event.buf, desc = "LSP: " .. desc }
      )
    end

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
    map("gr", fzf.lsp_references, "[G]oto [R]eferences")
    map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map("<leader>D", fzf.lsp_typedefs, "Type [D]efinition")

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map("<leader>ws", fzf.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", fzf.lsp_code_actions, "[C]ode [A]ction")

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    vim.keymap.set(
      "i",
      "<C-h>",
      function() end,
      { buffer = event.buf, desc = "LSP: [H]elp" }
    )

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = detach_augroup,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = highlight_augroup,
            buffer = event2.buf,
          })
        end,
      })
    end

    -- The following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if
      client
      and client.server_capabilities.inlayHintProvider
      and vim.lsp.inlay_hint
    then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})
