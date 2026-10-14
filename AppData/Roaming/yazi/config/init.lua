-- Show modified time of the file under the cursor on the status line
Status:children_add(function()
  local h = cx.active.current.hovered
  return ui.Line({
    ui.Span(os.date('%Y-%m-%d %H:%M', h.cha.mtime // 1)):fg('blue'),
    ui.Span(' '),
  })
end, 500, Status.RIGHT)

-- require("git"):setup()
require('pref-by-location'):setup({})

require('mime-ext.local'):setup({
  -- Expand the existing extension database (lowercase), for example:
  with_exts = {
    mk = 'text/makefile',
    ahk = 'text/autohotkey',
    nu = 'text/nu',
  },

  -- If the mime-type is not in both filename and extension databases,
  -- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
  fallback_file1 = true,
})

local map_mgr = function(key, action, desc)
  km.mgr.rules:insert(1, { on = key, run = action, desc = desc })
end

local is_wsl = os.getenv('WSL_DISTRO_NAME') or os.getenv('WSL_INTEROP')
local is_wayland = os.getenv('WAYLAND_DISPLAY')

local clip
if ya.target_os() == 'windows' or is_wsl then
  clip = 'clip.exe'
elseif is_wayland then
  clip = 'wl-copy'
else
  clip = 'xclip -selection clipboard'
end

-- keymaps for nu.yazi plugin
map_mgr({ 'c', 't' }, 'plugin nu -- open -r $hover | ' .. clip, 'Copy the file contents')
map_mgr({ 'c', 'u' }, 'plugin nu -- $all | each { path url } | str join (char nl) | ' .. clip, 'Copy file url')
map_mgr({ 'c', 'a' }, [[plugin nu -- '$all | each { str sandwich "`" }' | str join " " | ]] .. clip, 'Copy as args')
map_mgr(
  { 'c', 'r' },
  "plugin nu -- '$all | path relative-to (git rev-parse --show-toplevel) | str replace -a \\ /' | to text | " .. clip,
  'Copy relative path'
)
