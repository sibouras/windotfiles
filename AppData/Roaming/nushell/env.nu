# Nushell Environment Config File

def create_left_prompt [] {
  let path_segment = if (is-admin) {
    $" (ansi red_bold)($env.PWD | str replace $nu.home-path '~')"
  } else {
    $" (ansi green_bold)($env.PWD | str replace $nu.home-path '~')"
  }

  let duration_segment = (do {
    let duration_secs = ($env.CMD_DURATION_MS | into int) / 1000
    if ($duration_secs >= 1) {
      $" (ansi yellow_bold)($duration_secs | math round | into string | append "sec" | str join | into duration)"
    } else {
      ""
    }
  })

  let exit_code_segment = if ($env.LAST_EXIT_CODE == 0) {
    ""
  } else {
    $" (ansi red_bold)($env.LAST_EXIT_CODE)"
  }

  let git_branch_segment = if ('.git' | path exists) {
    let content = open .git\HEAD
    if ($content | str starts-with 'ref') {
      $" (ansi xterm_mediumpurple2a)($content | split words | last)(ansi xterm_mediumpurple2a)"
    } else {
      $" (ansi xterm_mediumpurple2a)($content | str substring ..7)(ansi xterm_mediumpurple2a)"
    }
  } else {
    ""
  }

  [$path_segment, $exit_code_segment, $git_branch_segment, $duration_segment] | str join
}

def create_right_prompt [] {
  let time_segment = ([
    (date now | format date '%m/%d/%Y %r')
  ] | str join)

  $time_segment
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
# $env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR = "\r\n ➜ "
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
  ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.LF_ICONS = "tw=:st=:ow=:dt=:di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf=:*.nix=:"
$env.EDITOR = "nvim"
$env.BOOKMARK_MANAGER_CSV = $"($nu.home-path)/documents/bm/bm.csv"

### zoxide config
# zoxide init nushell | save -f ~/.cache/.zoxide.nu

### starship config
# starship init nu | save -f ~/.cache/starship/init.nu

### oh-my-posh config
# oh-my-posh init nu --config ~/.config/.pure-theme.omp.json
