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

return {
  s({ trig = "l", dscr = "link" }, fmt("[{}]({})", { i(1), i(2) })),
  s({ trig = "img", dscr = "image" }, fmt("![{}]({})", { i(1), i(2) })),
  s(
    "codeblock",
    fmt(
      [[
        ```{}
        {}
        ```
      ]],
      { i(1), i(2) }
    )
  ),
}
