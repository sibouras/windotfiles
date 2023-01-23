local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local types = require("luasnip.util.types")

-- require("luasnip.loaders.from_vscode").lazy_load({
--   paths = vim.fn.stdpath("config") .. "/snippets",
-- })
-- require("luasnip.loaders.from_vscode").load({ paths = ".\\snippets" })

require("luasnip.loaders.from_lua").lazy_load({ paths = ".\\luasnippets" })

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })

ls.config.set_config({
  history = true,
  update_events = "TextChanged,TextChangedI",
  -- region_check_events = "CursorMoved,CursorHold,InsertEnter",
  -- delete_check_events = "InsertLeave",
  -- This can be especially useful when `history` is enabled.
  delete_check_events = "TextChanged",
  enable_autosnippets = true,
  -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
  -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
  store_selection_keys = "<Tab>",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "«", "DiagnosticInfo" } },
      },
    },
  },
})

-- new way: https://github.com/L3MON4D3/LuaSnip/issues/81
ls.add_snippets(nil, {
  all = {
    s(
      "curtime",
      f(function()
        return os.date("%D - %H:%M")
      end)
    ),
  },
})

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
  -- if ls.jumpable(1) then
  --   ls.jump(1)
  -- end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

-- vim.keymap.set("n", "<leader>s", ":source $LOCALAPPDATA/nvim/lua/user/luasnip.lua<CR>")
