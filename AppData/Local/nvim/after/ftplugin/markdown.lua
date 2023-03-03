vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 0

local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

-- search markdown links
map("n", "<Tab>", "<Cmd>call search('\\[[^]]*\\]([^)]\\+)')<CR>", opts)
map("n", "<S-Tab>", "<Cmd>call search('\\[[^]]*\\]([^)]\\+)', 'b')<CR>", opts)

-- open url if markdown link is a url else `gf`
map("n", "<CR>", ":lua require('user.essentials').go_to_url('start')<CR>", opts)

local status_ok, various_textobjs = pcall(require, "various-textobjs")
if not status_ok then
  return
end

map({ "o", "x" }, "aC", function() various_textobjs.mdFencedCodeBlock(false) end)
map({ "o", "x" }, "iC", function() various_textobjs.mdFencedCodeBlock(true) end)
