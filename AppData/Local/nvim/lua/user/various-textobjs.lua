local status_ok, vt = pcall(require, "various-textobjs")
if not status_ok then
  return
end

vt.setup({
  useDefaultKeymaps = false,
})

local map = vim.keymap.set

-- example: `?` for diagnostic textobj
map({ "o", "x" }, "?", "<Cmd>lua require('various-textobjs').diagnostic()<CR>")
-- near EoL: from cursor position to end of line, minus one character
map({ "o", "x" }, "m", "<Cmd>lua require('various-textobjs').nearEoL()<CR>")
-- like }, but linewise
map({ "o", "x" }, "<CR>", "<Cmd>lua require('various-textobjs').restOfParagraph()<CR>")
-- rest of indentation
map({ "o", "x" }, "R", "<Cmd>lua require('various-textobjs').restOfIndentation()<CR>")
-- from cursor to next closing ], ), or }
map({ "o", "x" }, "T", "<Cmd>lua require('various-textobjs').toNextClosingBracket()<CR>")
-- column down until indent or shorter line.
map({ "o", "x" }, "|", "<Cmd>lua require('various-textobjs').column()<CR>")
-- entire buffer
map({ "o", "x" }, "gG", "<Cmd>lua require('various-textobjs').entireBuffer()<CR>")
-- url
map({ "o", "x" }, "<BS>", "<Cmd>lua require('various-textobjs').url()<CR>")

-- example: `aS` for outer subword, `iS` for inner subword
map({ "o", "x" }, "aS", "<Cmd>lua require('various-textobjs').subword(false)<CR>")
map({ "o", "x" }, "iS", "<Cmd>lua require('various-textobjs').subword(true)<CR>")
-- key/value
map({ "o", "x" }, "ak", "<Cmd>lua require('various-textobjs').key(false)<CR>")
map({ "o", "x" }, "ik", "<Cmd>lua require('various-textobjs').key(true)<CR>")
map({ "o", "x" }, "av", "<Cmd>lua require('various-textobjs').value(false)<CR>")
map({ "o", "x" }, "iv", "<Cmd>lua require('various-textobjs').value(true)<CR>")
-- class in CSS, like .my-class
map({ "o", "x" }, "ac", "<Cmd>lua require('various-textobjs').cssSelector(false)<CR>")
map({ "o", "x" }, "ic", "<Cmd>lua require('various-textobjs').cssSelector(true)<CR>")
-- html attribute
map(
  { "o", "x" },
  "ax",
  "<Cmd>lua require('various-textobjs').htmlAttribute(false)<CR>",
  { desc = "outer html attribute" }
)
map(
  { "o", "x" },
  "ix",
  "<Cmd>lua require('various-textobjs').htmlAttribute(true)<CR>",
  { desc = "inner html attribute" }
)

-- exception: indentation textobj requires two parameters, first for exclusion of the
-- starting border, second for the exclusion of ending border
map(
  { "o", "x" },
  "ii",
  "<Cmd>lua require('various-textobjs').indentation(true, true)<CR>",
  { desc = "inner-inner indentation textobj" }
)
map(
  { "o", "x" },
  "ai",
  "<Cmd>lua require('various-textobjs').indentation(false, true)<CR>",
  { desc = "outer-inner indentation textobj" }
)
map(
  { "o", "x" },
  "iI",
  "<Cmd>lua require('various-textobjs').indentation(true, false)<CR>",
  { desc = "inner-outer indentation textobj" }
)
map(
  { "o", "x" },
  "aI",
  "<Cmd>lua require('various-textobjs').indentation(false, false)<CR>",
  { desc = "outer-outer indentation textobj" }
)

-- Delete Surrounding Indentation
map("n", "dsi", function()
  -- select inner indentation
  require("various-textobjs").indentation(true, true)

  -- plugin only switches to visual mode when textobj found
  local notOnIndentedLine = vim.fn.mode():find("V") == nil
  if notOnIndentedLine then
    return
  end

  -- dedent indentation
  vim.cmd.normal({ "<", bang = true })

  -- delete surrounding lines
  local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
  local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
  vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
  vim.cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete surrounding indentation" })
