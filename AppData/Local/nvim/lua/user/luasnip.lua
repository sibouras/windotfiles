local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

-- require("luasnip.loaders.from_vscode").lazy_load({
--   paths = vim.fn.stdpath("config") .. "/snippets",
-- })
require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

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
})

local function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

-- new way: https://github.com/L3MON4D3/LuaSnip/issues/81
ls.add_snippets(nil, {
  markdown = {
    s(
      "curtime",
      f(function()
        return os.date("%D - %H:%M")
      end)
    ),
  },
  lua = {
    -- s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
  },
  javascript = {
    --[[ s("clw", {
      -- the surrounding snippet is passed in args after all argnodes (none,
      -- in this case).
      f(function(args, snip)
        return "console.log(" .. snip.env.SELECT_RAW[1] .. ")"
      end, {}),
    }), ]]
  },
  javascriptreact = {
    s(
      "us",
      fmt(
        "const [{}, {}] = useState({})",
        { i(1), f(function(state)
          return "set" .. firstToUpper(state[1][1])
        end, { 1 }), i(0) }
      )
    ),
  },
})

-- source: https://gist.github.com/davidatsurge/9873d9cb1781f1a37c0f25d24cb1b3ab
-- Get a list of  the property names given an `interface_declaration`
-- treesitter *tsx* node.
-- Ie, if the treesitter node represents:
--   interface {
--     prop1: string;
--     prop2: number;
--   }
-- Then this function would return `{"prop1", "prop2"}
---@param id_node {} Stands for "interface declaration node"
---@return string[]
local function get_prop_names(id_node)
  local object_type_node = id_node:child(2)
  if object_type_node:type() ~= "object_type" then
    return {}
  end

  local prop_names = {}

  for prop_signature in object_type_node:iter_children() do
    if prop_signature:type() == "property_signature" then
      local prop_iden = prop_signature:child(0)
      local prop_name = vim.treesitter.query.get_node_text(prop_iden, 0)
      prop_names[#prop_names + 1] = prop_name
    end
  end

  return prop_names
end

ls.add_snippets("typescriptreact", {
  s(
    "c",
    fmt(
      [[
        {}interface {}Props {{
          {}
        }}

        {}function {}({{{}}}: {}Props) {{
          {}
        }}
      ]],
      {
        i(1, "export "),

        -- Initialize component name to file name
        d(2, function(_, snip)
          return sn(nil, {
            i(1, vim.fn.substitute(snip.env.TM_FILENAME, "\\..*$", "", "g")),
          })
        end, { 1 }),
        i(3, "// props"),
        rep(1),
        rep(2),
        f(function(_, snip, _)
          local pos_begin = snip.nodes[6].mark:pos_begin()
          local pos_end = snip.nodes[6].mark:pos_end()
          local parser = vim.treesitter.get_parser(0, "tsx")
          local tstree = parser:parse()

          local node = tstree[1]:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

          while node ~= nil and node:type() ~= "interface_declaration" do
            node = node:parent()
          end

          if node == nil then
            return ""
          end

          -- `node` is now surely of type "interface_declaration"
          local prop_names = get_prop_names(node)

          -- Does this lua->vimscript->lua thing cause a slow down? Dunno.
          return vim.fn.join(prop_names, ", ")
        end, { 3 }),
        rep(2),
        i(5, "return <div></div>"),
      }
    )
  ),
})

-- vim.keymap.set({ "i", "s" }, "<a-p>", function()
--   if ls.expand_or_jumpable() then
--     ls.expand()
--   end
-- end, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<C-k>", function()
--   if ls.expand_or_jumpabale() then
--     ls.expand_or_jump()
--   end
-- end, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
--   if ls.jumpable(-1) then
--     ls.jump(-1)
--   end
-- end, { silent = true })

-- vim.keymap.set("i", "<C-l>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end)

-- vim.keymap.set("n", "<leader>s", ":source $LOCALAPPDATA/nvim/lua/user/luasnip.lua<CR>")
