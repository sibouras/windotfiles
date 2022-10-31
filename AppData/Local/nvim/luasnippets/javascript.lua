---@diagnostic disable: undefined-global

return {
  s("cl", fmt("console.log({})", { i(1) })),
  s("cd", fmt("console.dir({})", { i(1) })),
  s("ce", fmt("console.error({})", { i(1) })),
  s("cw", fmt("console.warn({})", { i(1) })),
  s(
    { trig = "cv", dscr = "console.log a variable" },
    fmt("console.log('{}:', {})", {
      d(2, function(args)
        local modules = vim.split(args[1][1], "%.")
        return sn(nil, { i(1, modules[#modules]) })
      end, { 1 }),
      i(1),
    })
  ),
  s("clw", {
    -- the surrounding snippet is passed in args after all argnodes (none,
    -- in this case).
    f(function(args, snip)
      return "console.log(" .. snip.env.SELECT_RAW[1] .. ")"
    end, {}),
  }),
  s({ trig = "im", dscr = "import" }, fmt("import {} from '{}'", { i(2, "foo"), i(1) })),
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
  s(
    { trig = "fn", dscr = "named function" },
    fmt(
      [[
        function {}({}) {{
          {}
        }}
      ]],
      { i(1), i(2), i(3) }
    )
  ),
  s(
    { trig = "tc", dscr = "try/catch" },
    fmt(
      [[
        try {{
          {}
        }} catch ({}) {{
          {}
        }}
      ]],
      { i(1), i(2, "err"), i(3) }
    )
  ),
}
