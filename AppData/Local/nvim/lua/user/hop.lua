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
