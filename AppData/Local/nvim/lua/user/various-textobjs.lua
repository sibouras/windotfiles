local status_ok, various_textobjs = pcall(require, "various-textobjs")
if not status_ok then
  return
end

various_textobjs.setup({
  useDefaultKeymaps = false,
})

local map = vim.keymap.set

-- stylua: ignore start
-- example: `?` for diagnostic textobj
map({ "o", "x" }, "?", function() various_textobjs.diagnostic() end)
-- near EoL: from cursor position to end of line, minus one character
map({ "o", "x" }, "m", function() various_textobjs.nearEoL() end)
-- rest of indentation
map({ "o", "x" }, "R", function() various_textobjs.restOfIndentation() end)
-- column down until indent or shorter line.
map({ "o", "x" }, "|", function() various_textobjs.column() end)
-- entire buffer
map({ "o", "x" }, "gG", function() various_textobjs.entireBuffer() end)
-- url
map({ "o", "x" }, "L", function() various_textobjs.url() end)

-- example: `an` for outer number, `in` for inner number
map({ "o", "x" }, "an", function() various_textobjs.number(false) end)
map({ "o", "x" }, "in", function() various_textobjs.number(true) end)
-- subword
map({ "o", "x" }, "aS", function() various_textobjs.subword(false) end)
map({ "o", "x" }, "iS", function() various_textobjs.subword(true) end)
-- key/value
map({ "o", "x" }, "ak", function() various_textobjs.key(false) end)
map({ "o", "x" }, "ik", function() various_textobjs.key(true) end)
map({ "o", "x" }, "av", function() various_textobjs.value(false) end)
map({ "o", "x" }, "iv", function() various_textobjs.value(true) end)
-- class in CSS, like .my-class
map({ "o", "x" }, "ac", function() various_textobjs.cssSelector(false) end)
map({ "o", "x" }, "ic", function() various_textobjs.cssSelector(true) end)
-- stylua: ignore end

-- exception: indentation textobj requires two parameters, first for exclusion of the
-- starting border, second for the exclusion of ending border
map({ "o", "x" }, "ii", function()
  various_textobjs.indentation(true, true)
end, { desc = "inner-inner indentation textobj" })
map({ "o", "x" }, "ai", function()
  various_textobjs.indentation(false, true)
end, { desc = "outer-inner indentation textobj" })
map({ "o", "x" }, "iI", function()
  various_textobjs.indentation(true, false)
end, { desc = "inner-outer indentation textobj" })
map({ "o", "x" }, "aI", function()
  various_textobjs.indentation(false, false)
end, { desc = "outer-outer indentation textobj" })
