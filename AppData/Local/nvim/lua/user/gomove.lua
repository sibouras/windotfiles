local status_ok, gomove = pcall(require, "gomove")
if not status_ok then
  return
end

gomove.setup({
  -- whether or not to map default key bindings, (true/false)
  map_defaults = false,
  -- whether or not to reindent lines moved vertically (true/false)
  reindent = true,
  -- whether or not to undojoin same direction moves (true/false)
  undojoin = true,
  -- whether to not to move past end column when moving blocks horizontally, (true/false)
  move_past_end_col = false,
})

local map = vim.keymap.set

---------------------------------------------------------------
-- => gomove.nvim
---------------------------------------------------------------
map("n", "<M-Left>", "<Plug>GoNSMLeft", { noremap = false })
map("n", "<M-Down>", "<Plug>GoNSMDown", { noremap = false })
map("n", "<M-Up>", "<Plug>GoNSMUp", { noremap = false })
map("n", "<M-Right>", "<Plug>GoNSMRight", { noremap = false })

map("x", "<M-Left>", "<Plug>GoVSMLeft", { noremap = false })
map("x", "<M-Down>", "<Plug>GoVSMDown", { noremap = false })
map("x", "<M-Up>", "<Plug>GoVSMUp", { noremap = false })
map("x", "<M-Right>", "<Plug>GoVSMRight", { noremap = false })

map("n", "<M-S-Left>", "<Plug>GoNSDLeft", { noremap = false })
map("n", "<M-S-Down>", "<Plug>GoNSDDown", { noremap = false })
map("n", "<M-S-Up>", "<Plug>GoNSDUp", { noremap = false })
map("n", "<M-S-Right>", "<Plug>GoNSDRight", { noremap = false })

map("x", "<M-S-Left>", "<Plug>GoVSDLeft", { noremap = false })
map("x", "<M-S-Down>", "<Plug>GoVSDDown", { noremap = false })
map("x", "<M-S-Up>", "<Plug>GoVSDUp", { noremap = false })
map("x", "<M-S-Right>", "<Plug>GoVSDRight", { noremap = false })

