---@diagnostic disable: undefined-global

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
