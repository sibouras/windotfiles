# Nushell Environment Config File

def create_left_prompt [] {
  let path_segment = if (is-admin) {
    $" (ansi red_bold)($env.PWD | str replace $nu.home-dir '~')"
  } else {
    $" (ansi green_bold)($env.PWD | str replace $nu.home-dir '~')"
  }

  let duration_segment = do {
    let duration_secs = ($env.CMD_DURATION_MS | into int) / 1000
    if ($duration_secs >= 1) {
      $" (ansi yellow_bold)($duration_secs | math round | into string | append "sec" | str join | into duration)"
    } else {
      ""
    }
  }

  let yazi_segment = do -i {
    let yazi_level = ($env.YAZI_LEVEL | into int)
    if ($yazi_level >= 1) {
      $" (ansi yellow)(1..$yazi_level | each {''} | str join ' ')"
    }
  }

  let exit_code_segment = if ($env.LAST_EXIT_CODE == 0) {
    ""
  } else {
    $" (ansi red_bold)($env.LAST_EXIT_CODE)"
  }

  let git_branch_segment = if ('.git/HEAD' | path exists) {
    let content = open .git/HEAD
    if ($content | str starts-with 'ref') {
      $" (ansi xterm_mediumpurple2a)($content | split row '/' | str trim | last)"
    } else {
      $" (ansi xterm_mediumpurple2a)($content | str substring ..7)"
    }
  } else {
    ""
  }

  [$yazi_segment, $path_segment, $exit_code_segment, $git_branch_segment, $duration_segment, $"(char eol) "] | str join
}

def create_right_prompt [] {
  let time_segment = ([
    (date now | format date '%m/%d/%Y %r')
  ] | str join)

  $time_segment
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = "➜ "
$env.PROMPT_INDICATOR_VI_NORMAL = ": "
$env.PROMPT_INDICATOR_VI_INSERT = "> "

$env.EDITOR = 'nvim'
$env.VISUAL = $env.EDITOR
$env.COLORTERM = "truecolor"
$env.LESS = '--quiet'
$env.MOOR = '--no-statusbar --style=github-dark'
$env.PAGER = 'moor --no-linenumbers -quit-if-one-screen'
$env.BAT_THEME = 'base16'
$env.TAILSPIN_PAGER = "moor --follow [FILE]"
$env.HELIX_RUNTIME = $'($env.USERPROFILE)\src\helix\runtime'
$env.YAZI_FILE_ONE = 'C:\Program Files\Git\usr\bin\file.exe'
$env.NU_HELPER = '--help'
# vivid generate my_tokyonight-night | save -f ($nu.data-dir | path join ls_colors.txt)
$env.LS_COLORS = open -r ($nu.data-dir | path join ls_colors.txt)

$env.RESTIC_REPOSITORY = ($env.USERPROFILE)\a\restic-repo
$env.RESTIC_PASSWORD = 'pass'

$env.FZF_DEFAULT_COMMAND = "fd --hidden --exclude .git --exclude node_modules"
$env.FZF_DEFAULT_OPTS = (
  "--cycle --highlight-line --color=bg+:#1d1e22, "
  + "--bind ctrl-right:forward-word,ctrl-left:backward-word,ctrl-p:toggle-preview,ctrl-s:change-multi,"
  + "ctrl-down:preview-half-page-down,ctrl-up:preview-half-page-up,ctrl-a:toggle-all,alt-s:toggle-sort,alt-w:toggle-preview-wrap,"
  + "ctrl-f:page-down,ctrl-b:page-up,ctrl-j:half-page-down,ctrl-k:half-page-up"
)

# prepend binaries to path to improve their startup time
$env.PATH = [
  $"($env.USERPROFILE)\\a\\links", # links to scoop shims(they slow down startup time)
  $"($env.USERPROFILE)\\a\\bin",
  $"($env.USERPROFILE)\\.local\\bin",
  $"($env.USERPROFILE)\\AppData\\Local\\Microsoft\\WinGet\\Links",
  ...$env.PATH
] | uniq
