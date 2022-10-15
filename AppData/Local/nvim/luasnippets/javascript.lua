---@diagnostic disable: undefined-global

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
