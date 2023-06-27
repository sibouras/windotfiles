# Nushell Config File

# For more information on themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
let dark_theme = {
  # color for nushell primitives
  separator: white
  leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
  header: green_bold
  empty: blue
  # Closures can be used to choose colors for specific values.
  # The value (in this case, a bool) is piped into the closure.
  bool: {|| if $in { 'light_cyan' } else { 'light_gray' } }
  int: white
  filesize: {|e|
    if $e == 0b {
      'white'
    } else if $e < 1mb {
      'cyan'
    } else { 'blue' }
  }
  duration: white
  date: {|| (date now) - $in |
    if $in < 1hr {
      'purple'
    } else if $in < 6hr {
      'red'
    } else if $in < 1day {
      'yellow'
    } else if $in < 3day {
      'green'
    } else if $in < 1wk {
      'light_green'
    } else if $in < 6wk {
      'cyan'
    } else if $in < 52wk {
      'blue'
    } else { 'dark_gray' }
  }
  range: white
  float: white
  string: white
  nothing: white
  binary: white
  cellpath: white
  row_index: green_bold
  record: white
  list: white
  block: white
  hints: dark_gray

  shape_and: purple_bold
  shape_binary: purple_bold
  shape_block: blue_bold
  shape_bool: light_cyan
  shape_closure: green_bold
  shape_custom: green
  shape_datetime: cyan_bold
  shape_directory: cyan
  shape_external: cyan
  shape_externalarg: green_bold
  shape_filepath: cyan
  shape_flag: blue_bold
  shape_float: purple_bold
  # shapes are used to change the cli syntax highlighting
  shape_garbage: { fg: white bg: red attr: b}
  shape_globpattern: cyan_bold
  shape_int: purple_bold
  shape_internalcall: cyan_bold
  shape_list: cyan_bold
  shape_literal: blue
  shape_match_pattern: green
  shape_matching_brackets: { attr: u }
  shape_nothing: light_cyan
  shape_operator: yellow
  shape_or: purple_bold
  shape_pipe: purple_bold
  shape_range: yellow_bold
  shape_record: cyan_bold
  shape_redirection: purple_bold
  shape_signature: green_bold
  shape_string: green
  shape_string_interpolation: cyan_bold
  shape_table: blue_bold
  shape_variable: purple
  shape_vardecl: purple
}

# External completer example
# let carapace_completer = {|spans|
#     carapace $spans.0 nushell $spans | from json
# }


# The default config record. This is where much of your global configuration is setup.
let-env config = {
  show_banner: false # true or false to enable or disable the banner
  ls: {
    use_ls_colors: true # use the LS_COLORS environment variable to colorize output
    clickable_links: true # enable or disable clickable links. Your terminal has to support links.
  }
  rm: {
    always_trash: true # always act as if -t was given. Can be overridden with -p
  }
  cd: {
    abbreviations: true # allows `cd s/o/f` to expand to `cd some/other/folder`
  }
  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    # A strategy of managing table view in case of limited space.
    show_empty: true # show 'empty list' and 'empty record' placeholders for command output
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }

  explore: {
    help_banner: true
    exit_esc: true

    command_bar_text: '#C4C9C6'
    # command_bar: {fg: '#C4C9C6' bg: '#223311' }

    status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6' }
    # status_bar_text: {fg: '#C4C9C6' bg: '#223311' }

    highlight: {bg: 'yellow' fg: 'black' }

    status: {
      # warn: {bg: 'yellow', fg: 'blue'}
      # error: {bg: 'yellow', fg: 'blue'}
      # info: {bg: 'yellow', fg: 'blue'}
    }

    try: {
      # border_color: 'red'
      # highlighted_color: 'blue'

      # reactive: false
    }

    table: {
      split_line: '#404040'

      cursor: true

      line_index: true
      line_shift: true
      line_head_top: true
      line_head_bottom: true

      show_head: true
      show_index: true

      # selected_cell: {fg: 'white', bg: '#777777'}
      # selected_row: {fg: 'yellow', bg: '#C1C2A3'}
      # selected_column: blue

      # padding_column_right: 2
      # padding_column_left: 2

      # padding_index_left: 2
      # padding_index_right: 1
    }

    config: {
      cursor_color: {bg: 'yellow' fg: 'black' }

      # border_color: white
      # list_color: green
    }
  }

  history: {
    max_size: 20000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
    history_isolation: false # true enables history isolation, false disables it. true will allow the history to be isolated to the current session. false will allow the history to be shared across all sessions.
  }
  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null # check 'carapace_completer' above as an example
    }
  }
  filesize: {
    metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }
  cursor_shape: {
    emacs: line # block, underscore, line (line is the default)
    vi_insert: block # block, underscore, line (block is the default)
    vi_normal: underscore # block, underscore, line  (underscore is the default)
  }
  color_config: $dark_theme   # if you want a light theme, replace `$dark_theme` to `$light_theme`
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  buffer_editor: "hx" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  edit_mode: emacs # emacs, vi
  shell_integration: false # enables terminal markers and a workaround to arrow keys stop working issue
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

  hooks: {
    pre_prompt: [{||
      null  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{||
      null  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        null  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
    display_output: {||
      if (term size).columns >= 100 { table -e } else { table }
    }
    command_not_found: {||
      null  # replace with source code to return an error message when a command is not found
    }
  }
  menus: [
      # Configuration for default nushell menus
      # Note the lack of souce parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
          layout: columnar
          columns: 4
          col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
          col_padding: 2
        }
        style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
          layout: list
          page_size: 10
        }
        style: {
          selected_text: green_reverse
          text: green
          description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
          layout: description
          columns: 4
          col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
          col_padding: 2
          selection_rows: 4
          description_rows: 10
        }
        style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
          layout: columnar
          columns: 4
          col_width: 20
          col_padding: 2
        }
        style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
        }
        source: { |buffer, position|
          $nu.scope.commands
          | where name =~ $buffer
          | each { |it| {value: $it.name description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
          layout: list
          page_size: 10
        }
        style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
        }
        source: { |buffer, position|
          $nu.scope.vars
          | where name =~ $buffer
          | sort-by name
          | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
          layout: description
          columns: 4
          col_width: 20
          col_padding: 2
          selection_rows: 4
          description_rows: 10
        }
        style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
        }
        source: { |buffer, position|
          $nu.scope.commands
          | where name =~ $buffer
          | each { |it| {value: $it.name description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [emacs vi_normal vi_insert]
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control_shift
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: redo_or_next_page
      modifier: control_shift
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupagenext }
          { edit: redo }
        ]
      }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    {
      name: cut_current_line
      modifier: alt
      keycode: char_r
      mode: emacs
      event: {
        until: [
          { edit: CutCurrentLine }
        ]
      }
    }
    {
      name: swap_words
      modifier: alt
      keycode: char_s
      mode: emacs
      event: {
        until: [
          { edit: SwapWords }
        ]
      }
    }
    {
      name: reload_config
      modifier: none
      keycode: f5
      mode: emacs
      event: {
        send: executehostcommand,
        cmd: $"source '($nu.config-path)'"
      }
    }
    # encapsulate current command into brackets and give it a name.
    {
      name: temp_var
      modifier: alt
      keycode: char_v
      mode: [emacs , vi_normal, vi_insert]
      event: {
        send: executehostcommand
        cmd: "let-env temp_var = ($env | get -i temp_var | default 0 | $in + 1);
        let custom_var = (input 'enter variable name: ');
        let name = (if $custom_var == "" {$env.temp_var | into string | 't' + $in} else {$custom_var});
        commandline ('let ' + ($name) + ' = (' + (commandline) + '); $' + ($name))"
      }
    }

    # Keybindings used to trigger the user defined menus
    {
      name: trigger-help-menu
      modifier: control
      keycode: char_q
      mode: emacs
      event: {
        until: [
          { send: menu name: help_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
    {
      name: change_dir_with_fzf
      modifier: control
      keycode: char_d
      mode: emacs
      event:{
        send: executehostcommand,
        # cmd: "cd (ls | where type == dir | each { |it| $it.name} | str join (char nl) | fzf | decode utf-8 | str trim)"
        cmd: "cd (fd --hidden --type directory --exclude .git --exclude node_modules | fzf)"
      }
    }
    {
      name: fuzzy_history
      modifier: control
      keycode: Char_r
      mode: [emacs , vi_normal, vi_insert]
      event: {
        send: executehostcommand
        cmd: "commandline (history | each { |it| $it.command } | uniq | reverse | str join  (char nl) | fzf --tiebreak=chunk --layout=reverse  --multi --preview='echo {..}' --preview-window='bottom:3:wrap' --height=70% -q (commandline) | decode utf-8 | str trim)"
      }
    }
    {
      name: fuzzy_file
      modifier: control
      keycode: char_f
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand
        cmd: "commandline -a (fd --hidden --type file -E .git | fzf)"
      }
    }
  ]
}

### Aliases
alias :q = exit
alias md = mkdir
alias pwd = echo $env.PWD
alias v = nvim
alias ll = lsd -l
alias lg = lazygit
alias gu = gitui
alias gs = gswin64c
alias ga = git add
alias gst = git status
alias gss = git status -s
alias gb = git branch --sort=committerdate
alias gi = git rev-parse --abbrev-ref HEAD # in git
alias gd = git diff
alias gr = cd (git rev-parse --show-toplevel)
alias gg = git log --graph --pretty=format:'%C(bold red)%h%Creset -%C(bold green)%d%Creset %s %C(bold yellow)(%cr) %C(blue)%ad%Creset' --abbrev-commit --date=short
alias gloo = git log --pretty=format:'%C(yellow)%h %Cred%ad %Cgreen%d %Creset%s' --date=short
alias winconfig = git $"--git-dir=($env.USERPROFILE)\\.dotfiles" $"--work-tree=($env.USERPROFILE)"
alias dotfiles = lazygit $"--git-dir=($env.USERPROFILE)\\.dotfiles" $"--work-tree=($env.USERPROFILE)"
alias sfss = sfsu search
alias sfsl = sfsu list
# alias mpv = mpv $"--config-dir=($env.APPDATA)\\mpv" --no-border
alias vd = VirtualDesktop11
alias b = buku --suggest
alias timeitt = commandline $"timeit {(history | last 1 | first | get command)}" # a shortcut to apply timeit to the previous command


### Functions

extern t [...args] {
  NVIM_APPNAME=nvimtest nvim $args
}

def uptime [] {
  (sys).host.uptime
}

def hxh [] {
  hx --health | lines | skip 7 | to text | detect columns
}

def mem [] {
  (sys).mem | select total free used
}

# cmd duration
def dur [] {
  $env.CMD_DURATION_MS + 'ms' | into duration
}

# Set tab title
def title [name?: string] {
  if ($name == null) {
    $"(ansi title)($env.PWD | path basename)(ansi st)"
  } else {
    $"(ansi title)($name)(ansi st)"
  }
}

# Set tab color
def color [idx: int] {
  ansi -e ( ["2;15;", ($idx | into string), (",|") ] | str join )
}

# search for files with fd and preview them with fzf
extern fs [...args] {
  fd $args -H -t f -E .git | fzf --multi --ansi | str trim | lines
}

# search for files with fd and preview them with fzf and open them with nvim
extern fe [...args] {
  # let file = (fd -H -e txt -e json -e js -e jsx -e ts -e tsx -e css -e html -e md -e lua | fzf --multi --preview 'bat --style=numbers --color=always --line-range :500 {}' | decode utf-8 | str trim | lines)
  let files = (fs ($args | to text))
  if not ($files | is-empty) {
    nvim $files
  }
}

# search for media files with fd and fzf and open them with mpv
extern fm [...args] {
  let files = (fd $args -e mp4 -e webm -e mkv -e gif | fzf --multi | str trim | lines)
  if not ($files | is-empty) {
    let full_path = ($files | each {|it| $"($env.PWD)\\($it)"})
    mpv $full_path
  }
}

# preview files with fzf
extern fp [...args] {
  fd $args -H -t f -E .git -E node_modules | fzf --multi --preview 'bat --style=numbers --color=always --line-range :500 {}' | str trim | lines
}

# histry with fzf
def fh [] {
  let text = (history | reverse | get command | to text | fzf)
  # kbsend -text $text -currentWindow -charDelay 0
  commandline $text
}

# get aliases
# def get-aliases [] {
#   open $nu.config-path | lines | find alias | find -v aliases | split column '=' | select column1 column2 | rename Alias Command | update Alias {|f| $f.Alias | split row ' ' | last} | sort-by Alias
# }
def get-aliases [] {
  $nu | get scope | get aliases | update expansion { |c| $c.expansion | nu-highlight }
}

# ls by date (newer last)
def ld [
  --reverse(-r) #reverse order
] {
  if ($reverse | is-empty) or (not $reverse) {
    # ls | sort-by modified | reject type
    ls | sort-by modified | select name size modified
  } else {
    ls | sort-by modified -r | select name size modified
  }
}

def lsg [] {
  ls | sort-by type name -i | grid -c
}

# ls by type
def l [] {
  ls | sort-by type name | select name size modified
}

# ls sorted by extension
def le [] {
  ls | sort-by -i type name | insert ext {|| $in.name | path parse | get extension } | sort-by ext | reject ext type
}

# search for specific process
def psn [name: string] {
  ps | find $name
}

# kill specified process in name
def killn [name: string] {
  ps | find $name | each {|| kill -f $in.pid }
}

# git checkout interactive
def gci [] {
  git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} | delta" | str trim | git checkout $in
}

# git diff preview
def gdp [] {
  git diff --name-only | fzf --preview 'git diff {} | delta'
}

# push to git
def git-push [m: string] {
  git add -A
  git status
  git commit -am $"($m)"
  git push origin main
}

# git log (count)
def gl [count: int = 10] {
  git log $'--max-count=($count)'
}

# Universal help command, combining https://tldr.sh/ with nushell’s help for built-ins:
def ? [...terms] {
  if (
    which ($terms | first) | any { |it| $it.built-in or $it.path =~ ^Nushell }
  ) {
    help ($terms | str join " ")
  } else {
    tldr ($terms | str join "-")
  }
}

# Return random element from a list or a table
def get-random-entry [input] {
  $input |get (random integer 0..(($input|length) - 1))
}

# Shortcut function and competitions to search for commands in the selected category of nushell
def "nu-complete help categories" [] {
  help commands | get category | uniq
}

def hc [category?: string@"nu-complete help categories"] {
  help commands | select name category usage | move usage --after name | where category =~ $category
}

def show_banner [] {
  let ellie = [
    "     __  ,"
    " .--()°'.'"
    "'|, . ,'  "
    ' !_-(_\   '
  ]
  print $"(ansi reset)(ansi green)($ellie.0)"
  print $"(ansi green)($ellie.1)  (ansi yellow) (ansi yellow_bold)Nushell (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
  print $"(ansi green)($ellie.2)  (ansi light_blue) (ansi light_blue_bold)RAM (ansi reset)(ansi light_blue)((sys).mem.used) / ((sys).mem.total)(ansi reset)"
  print $"(ansi green)($ellie.3)  (ansi light_purple)ﮫ (ansi light_purple_bold)Uptime (ansi reset)(ansi light_purple)((sys).host.uptime)(ansi reset)"
}

# green echo
def echo-g [string:string] {
  echo $"(ansi -e { fg: '#A8D8B9' attr: b })($string)(ansi reset)"
}

# red echo
def echo-r [string:string] {
  echo $"(ansi -e { fg: '#ff0000' attr: b })($string)(ansi reset)"
}

# rm trough pipe
#
# Example
# ls *.txt | first 5 | rmp
def rmp [] {
  if not ($in | is-empty) {
    get name | ansi strip | par-each {|file| rm -rf $file }
  }
}

# cp trough pipe to same dir
def cpp [
  to: string # target directory
  #
  # Example
  # ls *.txt | first 5 | cp-pipe ~/temp
] {
  get name | each { |file| echo $"copying ($file)..." ; cp -r $file ($to | path expand) }
}

# mv trough pipe to same dir
def mvp [
  to: string # target directory
  #
  # Example
  # ls *.txt | mvp ~/temp
] {
  get name | each { |file| echo $"moving ($file)..." ; mv $file ($to | path expand) }
}

# rename a file
def mvr [
  path: string # e.g: dir/subdir/file.txt
  moveto: string # e.g: %/file2.txt
  #
  # Example
  # mvr dir/subdir/file.txt %/file2.txt
] {
  mv $path ($moveto | str replace % ($path | path dirname))
}

# last n elements in history with highlight(default 100)
def h [n = 20] {
  history | last $n | update command { |f| $f.command | nu-highlight }
}


# short pwd
def pwds [] {
  $env.PWD | str replace $nu.home-path '~' -s
}

# shorter pwd
def pwdss [sep?: string] {
  let sep = (if ($sep | is-empty) {
    char path_sep
  } else { $sep })

  let tokens = (
    ["!" $env.PWD] | str join
    | str replace -s (["!" $nu.home-path] | str join) "~"
    | split row $sep
  )

  $tokens
  | enumerate
  | each {|it|
    $it.item
    | if ($it.index != (($tokens | length) - 1)) {
      str substring (
        if ($it.item | str starts-with '.') { 0..2 } else { 0..1 }
      )
    } else { $it.item }
  }
  | path join
}

# Function querying free online English dictionary API for definition of given word(s)
def dict [...word #word(s) to query the dictionary API but they have to make sense together like "martial law", not "cats dogs"
] {
  let query = ($word | str join %20)
  let link = ('https://api.dictionaryapi.dev/api/v2/entries/en/' + $query)
  let output = (http get -e $link | rename word)
  if ($output.word == "No Definitions Found") {
    echo $output.word
  } else {
    echo $output.meanings | flatten | get definitions  | flatten
  }
}

# translate text using mymemmory api
def tr [
  ...search:string  # search query
  --from:string     # from which language you are translating (default english)
  --to:string       # to which language you are translating (default french)
  #
  # Use ISO standar names for the languages, for example:
  # english: en-US
  # spanish: es-ES
  # italian: it-IT
  # swedish: sv-SV
  #
  # More in: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
] {
  if ($search | is-empty) {
    echo-r "no search query provided"
  } else {
    let from = if ($from | is-empty) {"en-US"} else {$from}
    let to = if ($to | is-empty) {"fr-FR"} else {$to}
    let to_translate = ($search | str join "%20")
    let url = $"https://api.mymemory.translated.net/get?q=($to_translate)&langpair=($from)%7C($to)"

    http get $url
    | get responseData
    | get translatedText
  }
}

def tolink [name: string] {
  let url = $in
  let pre = "\e]8;;"
  let sp = "\e\\"
  $"($pre)($url)($sp)($name)($pre)($sp)"
}

# structured scoop list
def sl [] {
  sfsl | lines | range 1.. | parse -r '(?<name>\S+)\s+\|\s(?<version>\S+)\s+\|\s(?<source>\S+)\s+\|\s(?<updated>\d{4}-\d{2}-\d{2})' | sort-by updated
}

# scoop search structured wrapper (much faster)
def "sfsss" [
  term:string # the term to search for
] {
  sfsu search $term | parse -r '\s*(.*)\s*\((.*)\)' | rename package version
}

def "list todos" [] {
  rg "//.? ?TODO" . -n
  | lines
  | parse "{file}:{line}:{match}"
  | try {
    group-by file
    | transpose
    | reject column1.file
    | transpose -rid
  } catch {
    "no TODOs found in this directory"
  }
}

# output shortcuts set in config.nu, or use $env.config.keybindings
def "keybindings config" [] {
  open $nu.config-path -r | lines | skip (open $nu.config-path -r | lines | enumerate
  | each {|i| if $i.item =~ "keybindings" {$i.index}} | get 0) | str join "\n"
  | parse -r "[^#].*name: (?P<name>.*)\n.*modifier: (?P<modifier>.*)\n.*keycode: (?P<key>.*)"
}

# get windows service status
def get-win-svc [] {
  sc queryex type=service state=all |
  collect {|x| $x |
    parse -r '(?m)SERVICE_NAME:\s*(?<svc>\w*)\s*DISPLAY_NAME:\s*(?<dsp>.*)\s*TYPE\s*:\s*(?<type>[\da-f]*)\s*(?<typename>\w*)?\s*\s*STATE\s*:\s*(?<state>\d)\s*(?<status>\w*)\s*(?<state_opts>\(.*\))?\s*?WIN32_EXIT_CODE\s*:\s*(?<exit>\d*).*\s*SERVICE_EXIT_CODE\s*:\s*(?<svc_exit>\d)\s*.*\s*CHECKPOINT\s*:\s*(?<chkpt>.*)\s*WAIT_HINT\s*:\s(?<wait>.*)\s*PID\s*:\s*(?<pid>\d*)\s*FLAGS\s*:\s(?<flags>.*)?' |
    upsert status {|s|
      if $s.status == RUNNING {
        $"(ansi green)●(ansi reset)"
      } else {
        $"(ansi red)●(ansi reset)"
      }
    } | into int state exit svc_exit chkpt wait pid
  }
}

# go up n directories
def-env up [nb: int = 1] {
  let path = (1..($nb) | each {|_| ".."} | reduce {|it, acc| $acc + "\\" + $it})
  cd $path
}

# make and cd into a directory
def-env mcd [name: path] {
  mkdir $name ; cd $name
}

#cd to the folder where a binary is located
def-env which-cd [program] {
  let dir = (which $program | get path | path dirname)
  cd $dir.0
}

# cd with tere(Terminal file explorer)
def-env ce [...args] {
  let result = ( tere --autocd-timeout=off $args | str trim )
  cd $result
}

# cd with lf
def-env lc [args = "."] {
  let cmd_file = $"($env.TEMP)\\" + (random chars -l 6) + ".tmp";
  touch $cmd_file;
  lf -last-dir-path $cmd_file $args;
  let cmd = ((open $cmd_file) | str trim);
  rm $cmd_file;
  cd ($cmd | str replace "cd" "" | str trim)
}

# cd with broot
def-env br [args = "."] {
  # let cmd_file = (^mktemp | str trim);
  let cmd_file = $"($env.TEMP)\\" + (random chars -l 6) + ".tmp";
  touch $cmd_file;
  broot --outcmd $cmd_file $args;
  let cmd = ((open $cmd_file) | str trim);
  rm $cmd_file;
  cd (if ($cmd | str contains '"') {
    ($cmd | str replace "cd" "" | str trim | str substring "1,-1")
  } else {
    ($cmd | str replace "cd" "" | str trim)
  })
}

# Add the given paths to PATH
def-env "path-add" [
  --ret(-r) # return the env (useful in pipelines to avoid scoping)
  --prepend(-p) # prepend instead of appending.
  ...paths # the paths to add
  ] {
  let path_name = if "PATH" in $env { "PATH" } else { "Path" }
  let-env $path_name = (
    $env | get $path_name
    | if $prepend { prepend $paths } else { append $paths }
  )
  if $ret {
    $env | get $path_name
  }
}

path-add $"($env.LOCALAPPDATA)\\Mozilla Firefox"
path-add "C:\\Program Files (x86)\\Microsoft\\Edge\\Application"

### Scripts
source ~/Appdata/Roaming/nushell/scripts/format-number.nu
source ~/Appdata/Roaming/nushell/scripts/nu-sloc.nu
source ~/Appdata/Roaming/nushell/scripts/youtube.nu

### Completions
use ~/Appdata/Roaming/nushell/completions/git-completions.nu *

### zoxide
source ~/.cache/.zoxide.nu

### starship
# source ~/.cache/starship/init-temp.nu

### oh-my-posh
# source ~/.oh-my-posh.nu
