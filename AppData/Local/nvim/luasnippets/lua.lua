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
  -- s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
  -- e.g. local bar = require("foo.bar")
  s(
    "require",
    fmt([[local {} = require("{}")]], {
      d(2, function(args)
        local modules = vim.split(args[1][1], "%.")
        return sn(nil, { i(1, modules[#modules]) })
      end, { 1 }),
      i(1),
    })
  ),
  s("first snippet", {
    t("hi heee is myfirst"),
    i(1, "placeholder"),
    t({ "", "this is another text node" }),
  }),
  s(
    "second snippet",
    fmt(
      [[
      local {} = function({})
        {}
      end
      ]],
      {
        i(1, ""),
        c(2, { t("one"), t("myArg") }),
        i(3, ""),
      }
    )
  ),
}
