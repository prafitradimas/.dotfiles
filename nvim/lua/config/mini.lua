-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [']quote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({ n_lines = 500 })

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

-- Align text
-- prefix: {ga}
--
-- - Press s to enter split Lua pattern.
-- - Press j to choose justification side from available ones ("left", "center", "right", "none").
-- - Press m to enter merge delimiter.
-- - Press f to enter filter Lua expression to configure which parts will be affected (like "align only first column").
-- - Press i to ignore some commonly unwanted split matches.
-- - Press p to pair neighboring parts so they be aligned together.
-- - Press t to trim whitespace from parts.
-- - Press <BS> (backspace) to delete some last pre-step.
require("mini.align").setup()

-- Simple and easy statusline.
local statusline = require("mini.statusline")
-- set use_icons to true if you have a Nerd Font
statusline.setup({ use_icons = vim.g.have_nerd_font })

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return "%2l:%-2v"
end
