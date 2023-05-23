local status_ok, buffer_browser = pcall(require, "buffer_browser")
if not status_ok then
  return
end

buffer_browser.setup()

local map = vim.keymap.set

map({ "n", "i" }, "<M-Right>", function()
  buffer_browser.next()
end, { desc = "Next [B]uffer [[]" })

map({ "n", "i" }, "<M-Left>", function()
  buffer_browser.prev()
end, { desc = "Previous [B]uffer []]" })
