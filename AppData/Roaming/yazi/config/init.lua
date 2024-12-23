require("git"):setup()
require("folder-rules"):setup()

-- Show modified time of the file under the cursor on the status line
Status:children_add(function()
  local h = cx.active.current.hovered
  return ui.Line {
    -- ui.Span(os.date("%y-%m-%d %H:%M ", h.cha.mtime // 1)):fg("blue"),
    ui.Span(os.date(_, tostring(h.cha.mtime):sub(1, 10))):fg("blue"),
    ui.Span(" "),
  }
end, 500, Status.RIGHT)
