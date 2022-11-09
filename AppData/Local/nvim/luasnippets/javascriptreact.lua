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
}
