-- Show modified time of the file under the cursor on the status line
Status:children_add(function()
  local h = cx.active.current.hovered
  return ui.Line {
    -- ui.Span(os.date("%y-%m-%d %H:%M ", h.cha.mtime // 1)):fg("blue"),
    ui.Span(os.date(_, tostring(h.cha.mtime):sub(1, 10))):fg("blue"),
    ui.Span(" "),
  }
end, 500, Status.RIGHT)

require("git"):setup()
require("pref-by-location"):setup({})

require("mime-ext"):setup {
  -- Expand the existing extension database (lowercase), for example:
  with_exts = {
    mk = "text/makefile",
    ahk = "text/autohotkey",
  },

  -- If the mime-type is not in both filename and extension databases,
  -- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
  fallback_file1 = true,
}
