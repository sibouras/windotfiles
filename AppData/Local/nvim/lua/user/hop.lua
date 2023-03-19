local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup({
  keys = "sdfwerhjklaoiuvcxgntqpybz",
})

vim.cmd([[
  hi HopNextKey2 guifg=#0db9d7
]])

-- local map = vim.keymap.set

-- map("", "sf", "<cmd>HopChar2<CR>")
-- map("", "sg", "<cmd>HopChar1<CR>")
-- map("", "sj", "<cmd>HopLineStartAC<CR>")
-- map("", "sk", "<cmd>HopLineStartBC<CR>")
-- map("", "s/", "<cmd>HopPattern<CR>")
