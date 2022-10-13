local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

return {
  s(
    "us",
    fmt(
      "const [{}, {}] = useState({})",
      { i(1), f(function(state)
        return "set" .. firstToUpper(state[1][1])
      end, { 1 }), i(0) }
    )
  ),
}
