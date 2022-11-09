---@diagnostic disable: undefined-global

return {
  s("pm", t({ "package main", "", "" })),
  s("fp", fmt("fmt.Println({})", { i(1) })),
  s("fn", fmta("func <>(<>) <><>{\n\t<>\n}", { i(1), i(2), i(3), n(3, " ", ""), i(0) })),
}
