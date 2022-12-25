---@diagnostic disable: undefined-global

local function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

return {
  -- s(
  --   "us",
  --   fmt(
  --     "const [{}, {}] = useState({})",
  --     { i(1), f(function(state)
  --       return "set" .. firstToUpper(state[1][1])
  --     end, { 1 }), i(0) }
  --   )
  -- ),
  s("us", fmt("const [{}, {}] = useState({})", { i(1), dl(2, "set" .. l._1:gsub("^%l", string.upper), 1), i(3) })),
  s(
    { trig = "rfc", dscr = "React Functional Component" },
    fmt(
      [[
        function {}(){{
          return (
            <div>
              {}
            </div>
          )
        }}
      ]],
      {
        d(1, function(_, snip)
          return sn(nil, {
            i(1, vim.fn.substitute(snip.env.TM_FILENAME, "\\..*$", "", "g")),
          })
        end),
        i(2),
      }
    )
  ),
  s(
    { trig = "ue", dscr = "useEffect hook" },
    fmt(
      [[
        useEffect(() => {{
          {}
        }}{})
      ]],
      {
        i(1),
        c(2, { fmt(", [{}]", i(1)), t("") }),
      }
    )
  ),
}
