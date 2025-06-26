local fzf = require("fzf-lua")
local path = require("fzf-lua.path")

vim.keymap.set("n", "<leader>sf", function(opts)
  opts = opts or {}

  local git_root = path.git_root(opts, true)
  if git_root then
    local relative = path.relative_to(vim.loop.cwd(), git_root)
    opts.fzf_opts = { ["--query"] = git_root ~= relative and relative or nil }
    return fzf.git_files(opts)
  end

  return fzf.files(opts)
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set(
  "n",
  "<leader>sg",
  fzf.live_grep,
  { desc = "[S]earch by [G]rep" }
)
vim.keymap.set(
  "n",
  "<leader>/",
  fzf.lgrep_curbuf,
  { desc = "[/] Fuzzily search in current buffer" }
)
vim.keymap.set(
  "n",
  "<leader>sw",
  fzf.grep_cword,
  { desc = "[S]earch current [W]ord" }
)
vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set(
  "n",
  "<leader>ss",
  fzf.grep_visual,
  { desc = "[S]earch [S]elect" }
)
vim.keymap.set("n", "<leader>sl", fzf.grep_last, { desc = "[S]earch [L]ast" })
vim.keymap.set(
  "n",
  "<leader>sd",
  fzf.diagnostics_document,
  { desc = "[S]earch [D]iagnostics Document" }
)
vim.keymap.set(
  "n",
  "<leader>sD",
  fzf.diagnostics_workspace,
  { desc = "[S]earch [D]iagnostics Workspace" }
)
vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set(
  "n",
  "<leader>s.",
  fzf.oldfiles,
  { desc = '[S]earch Recent Files ("." for repeat)' }
)
vim.keymap.set(
  "n",
  "<leader>sh",
  fzf.search_history,
  { desc = "[S]earch Search [H]istory" }
)
vim.keymap.set(
  "n",
  "<leader>sc",
  fzf.command_history,
  { desc = "[S]earch [C]ommand History" }
)

-- GIT

vim.keymap.set(
  "n",
  "<leader>Gc",
  fzf.git_bcommits,
  { desc = "[G]it [C]ommit Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>GC",
  fzf.git_commits,
  { desc = "[G]it [C]ommit Project" }
)
vim.keymap.set("n", "<leader>Gb", fzf.git_blame, { desc = "[G]it [B]lame" })
vim.keymap.set("n", "<leader>Gs", fzf.git_status, { desc = "[G]it [S]tatus" })
vim.keymap.set("n", "<leader>GS", fzf.git_status, { desc = "[G]it [S]tash" })
