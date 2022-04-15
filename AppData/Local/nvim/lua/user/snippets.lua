local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

-- local snippet = ls.snippet
-- local text = ls.text_node
-- local f = ls.function_node
-- local insert = ls.insert_node

ls.config.set_config({
  history = true,
  region_check_events = "CursorMoved,CursorHold,InsertEnter",
  delete_check_events = "InsertLeave",
  enable_autosnippets = true,
})

-- new way: https://github.com/L3MON4D3/LuaSnip/issues/81
-- ls.add_snippets(nil, {
--   all = {
--     ls.parser.parse_snippet("expan", "-- this is what was expanded!"),
--   },
-- })

require("luasnip.loaders.from_vscode").lazy_load({
  paths = vim.fn.stdpath("config") .. "/snippets",
})

-- vim.keymap.set({ "i", "s" }, "<C-k>", function()
--   if ls.expand_or_jumpabale() then
--     ls.expand_or_jump()
--   end
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
--   if ls.jumpable(-1) then
--     ls.jump(-1)
--   end
-- end, { silent = true })
--
-- vim.keymap.set("i", "<C-l>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end)
--
-- vim.keymap.set("n", "<leader>s", ":source $LOCALAPPDATA/nvim/lua/user/snippets.lua<CR>")
