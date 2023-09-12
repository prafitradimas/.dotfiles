require("personal.config.options")
require("personal.config.keymaps")
require("personal.config.pckr")
require("personal.install")
require("personal.plugins.lualine")
require("personal.plugins.telescope")
require("personal.plugins.trouble")
require("personal.plugins.undotree")
require("personal.plugins.lsp")
require("personal.lsp.go")

local augroup = vim.api.nvim_create_augroup
local PersonalGroup = augroup("PersonalGroup", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = PersonalGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
