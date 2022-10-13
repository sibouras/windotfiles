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
  s("clw", {
    -- the surrounding snippet is passed in args after all argnodes (none,
    -- in this case).
    f(function(args, snip)
      return "console.log(" .. snip.env.SELECT_RAW[1] .. ")"
    end, {}),
  }),
  s("cl", fmt("console.log({})", { i(1) })),
  s(
    { trig = "f", dscr = "arrow function" },
    fmt(
      [[
        ({}) => {{
          {}
        }}
      ]],
      { i(1), i(2) }
    )
  ),
  s(
    { trig = "np", dscr = "new Promise" },
    fmt(
      [[
        new Promise((resolve, reject) => {{
          {}
        }})
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "for", dscr = "for loop" },
    fmt(
      [[
        for (let {} = 0; {} < {}.length; {}++) {{
          {}
        }}
      ]],
      { i(1, "i"), rep(1), i(2, "arr"), rep(1), i(3) }
    )
  ),
}
