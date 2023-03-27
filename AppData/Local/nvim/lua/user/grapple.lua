local status_ok, grapple = pcall(require, "grapple")
if not status_ok then
  return
end

grapple.setup({
  scope = require("grapple.scope").resolver(function()
    return vim.fn.getcwd()
  end, { cache = "DirChanged" }),
})

local map = vim.keymap.set

map("n", "<M-e>", function()
  require("grapple").popup_tags()
end)

map("n", "<leader>ha", require("grapple").toggle)

map("n", "<M-j>", function()
  require("grapple").cycle_forward()
end, { desc = "cycle forwards to marked file" })

map("n", "<M-k>", function()
  require("grapple").cycle_backward()
end, { desc = "cycle backwards to marked file" })

for i = 1, 9 do
  map("n", i .. "<leader>", function()
    require("grapple").select({ key = i })
  end)
end
