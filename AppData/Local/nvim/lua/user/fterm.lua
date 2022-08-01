local status_ok, fterm = pcall(require, "FTerm")
if not status_ok then
  return
end

fterm.setup({
  cmd = "nu",
  border = "single",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

vim.keymap.set("n", "<M-;>", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<M-;>", "<C-\\><C-n>")
-- vim.keymap.set("n", "<M-/>", ":lua require('FTerm').run({'node', vim.fn.expand('%')})<CR>")

local lazygit = fterm:new({
  ft = "fterm_lazygit",
  cmd = "lazygit",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

function _FTERM_LAZYGIT()
  lazygit:toggle()
end

-- vim.keymap.set("n", "<M-'>", "<cmd>lua _FTERM_LAZYGIT()<CR>")
vim.keymap.set("n", "<M-'>", _FTERM_LAZYGIT)
vim.keymap.set("t", "<M-'>", _FTERM_LAZYGIT)
