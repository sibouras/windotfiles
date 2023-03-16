local status_ok, vt = pcall(require, "various-textobjs")
if not status_ok then
  return
end

vt.setup({
  useDefaultKeymaps = false,
})

local map = vim.keymap.set

-- stylua: ignore start
-- example: `?` for diagnostic textobj
map({ "o", "x" }, "?", function() vt.diagnostic() end)
-- near EoL: from cursor position to end of line, minus one character
map({ "o", "x" }, "m", function() vt.nearEoL() end)
-- like }, but linewise
map({ "o", "x" }, "<CR>", function() vt.restOfParagraph() end)
-- rest of indentation
map({ "o", "x" }, "R", function() vt.restOfIndentation() end)
-- from cursor to next closing ], ), or }
map({ "o", "x" }, "T", function() vt.toNextClosingBracket() end)
-- column down until indent or shorter line.
map({ "o", "x" }, "|", function() vt.column() end)
-- entire buffer
map({ "o", "x" }, "gG", function() vt.entireBuffer() end)
-- url
map({ "o", "x" }, "<BS>", function() vt.url() end)

-- example: `aS` for outer subword, `iS` for inner subword
map({ "o", "x" }, "aS", function() vt.subword(false) end)
map({ "o", "x" }, "iS", function() vt.subword(true) end)
-- key/value
map({ "o", "x" }, "ak", function() vt.key(false) end)
map({ "o", "x" }, "ik", function() vt.key(true) end)
map({ "o", "x" }, "av", function() vt.value(false) end)
map({ "o", "x" }, "iv", function() vt.value(true) end)
-- class in CSS, like .my-class
map({ "o", "x" }, "ac", function() vt.cssSelector(false) end)
map({ "o", "x" }, "ic", function() vt.cssSelector(true) end)
-- stylua: ignore end

-- exception: indentation textobj requires two parameters, first for exclusion of the
-- starting border, second for the exclusion of ending border
map({ "o", "x" }, "ii", function()
  vt.indentation(true, true)
end, { desc = "inner-inner indentation textobj" })
map({ "o", "x" }, "ai", function()
  vt.indentation(false, true)
end, { desc = "outer-inner indentation textobj" })
map({ "o", "x" }, "iI", function()
  vt.indentation(true, false)
end, { desc = "inner-outer indentation textobj" })
map({ "o", "x" }, "aI", function()
  vt.indentation(false, false)
end, { desc = "outer-outer indentation textobj" })
