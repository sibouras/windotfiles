# Nushell Config File

module completions {
  # Custom completions for external commands (those outside of Nushell)
  # Each completions has two parts: the form of the external command, including its flags and parameters
  # and a helper command that knows how to complete values for those flags and parameters
  #
  # This is a simplified version of completions for git branches and git remotes
  def "nu-complete git branches" [] {
    ^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
  }

  def "nu-complete git remotes" [] {
    ^git remote | lines | each { |line| $line | str trim }
  }

  # Download objects and refs from another repository
  export extern "git fetch" [
    repository?: string@"nu-complete git remotes" # name of the repository to fetch
    branch?: string@"nu-complete git branches" # name of the branch to fetch
    --all                                         # Fetch all remotes
    --append(-a)                                  # Append ref names and object names to .git/FETCH_HEAD
    --atomic                                      # Use an atomic transaction to update local refs.
    --depth: int                                  # Limit fetching to n commits from the tip
    --deepen: int                                 # Limit fetching to n commits from the current shallow boundary
    --shallow-since: string                       # Deepen or shorten the history by date
    --shallow-exclude: string                     # Deepen or shorten the history by branch/tag
    --unshallow                                   # Fetch all available history
    --update-shallow                              # Update .git/shallow to accept new refs
    --negotiation-tip: string                     # Specify which commit/glob to report while fetching
    --negotiate-only                              # Do not fetch, only print common ancestors
    --dry-run                                     # Show what would be done
    --write-fetch-head                            # Write fetched refs in FETCH_HEAD (default)
    --no-write-fetch-head                         # Do not write FETCH_HEAD
    --force(-f)                                   # Always update the local branch
    --keep(-k)                                    # Keep dowloaded pack
    --multiple                                    # Allow several arguments to be specified
    --auto-maintenance                            # Run 'git maintenance run --auto' at the end (default)
    --no-auto-maintenance                         # Don't run 'git maintenance' at the end
    --auto-gc                                     # Run 'git maintenance run --auto' at the end (default)
    --no-auto-gc                                  # Don't run 'git maintenance' at the end
    --write-commit-graph                          # Write a commit-graph after fetching
    --no-write-commit-graph                       # Don't write a commit-graph after fetching
    --prefetch                                    # Place all refs into the refs/prefetch/ namespace
    --prune(-p)                                   # Remove obsolete remote-tracking references
    --prune-tags(-P)                              # Remove any local tags that do not exist on the remote
    --no-tags(-n)                                 # Disable automatic tag following
    --refmap: string                              # Use this refspec to map the refs to remote-tracking branches
    --tags(-t)                                    # Fetch all tags
    --recurse-submodules: string                  # Fetch new commits of populated submodules (yes/on-demand/no)
    --jobs(-j): int                               # Number of parallel children
    --no-recurse-submodules                       # Disable recursive fetching of submodules
    --set-upstream                                # Add upstream (tracking) reference
    --submodule-prefix: string                    # Prepend to paths printed in informative messages
    --upload-pack: string                         # Non-default path for remote command
    --quiet(-q)                                   # Silence internally used git commands
    --verbose(-v)                                 # Be verbose
    --progress                                    # Report progress on stderr
    --server-option(-o): string                   # Pass options for the server to handle
    --show-forced-updates                         # Check if a branch is force-updated
    --no-show-forced-updates                      # Don't check if a branch is force-updated
    -4                                            # Use IPv4 addresses, ignore IPv6 addresses
    -6                                            # Use IPv6 addresses, ignore IPv4 addresses
    --help                                        # Display this help message
  ]

  # Check out git branches and files
  export extern "git checkout" [
    ...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
    --conflict: string                              # conflict style (merge or diff3)
    --detach(-d)                                    # detach HEAD at named commit
    --force(-f)                                     # force checkout (throw away local modifications)
    --guess                                         # second guess 'git checkout <no-such-branch>' (default)
    --ignore-other-worktrees                        # do not check if another worktree is holding the given ref
    --ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
    --merge(-m)                                     # perform a 3-way merge with the new branch
    --orphan: string                                # new unparented branch
    --ours(-2)                                      # checkout our version for unmerged files
    --overlay                                       # use overlay mode (default)
    --overwrite-ignore                              # update ignored files (default)
    --patch(-p)                                     # select hunks interactively
    --pathspec-from-file: string                    # read pathspec from file
    --progress                                      # force progress reporting
    --quiet(-q)                                     # suppress progress reporting
    --recurse-submodules: string                    # control recursive updating of submodules
    --theirs(-3)                                    # checkout their version for unmerged files
    --track(-t)                                     # set upstream info for new branch
    -b: string                                      # create and checkout a new branch
    -B: string                                      # create/reset and checkout a branch
    -l                                              # create reflog for new branch
    --help                                          # Display this help message
  ]

  # Push changes
  export extern "git push" [
    remote?: string@"nu-complete git remotes",      # the name of the remote
    ...refs: string@"nu-complete git branches"      # the branch / refspec
    --all                                           # push all refs
    --atomic                                        # request atomic transaction on remote side
    --delete(-d)                                    # delete refs
    --dry-run(-n)                                   # dry run
    --exec: string                                  # receive pack program
    --follow-tags                                   # push missing but relevant tags
    --force-with-lease                              # require old value of ref to be at this value
    --force(-f)                                     # force updates
    --ipv4(-4)                                      # use IPv4 addresses only
    --ipv6(-6)                                      # use IPv6 addresses only
    --mirror                                        # mirror all refs
    --no-verify                                     # bypass pre-push hook
    --porcelain                                     # machine-readable output
    --progress                                      # force progress reporting
    --prune                                         # prune locally removed refs
    --push-option(-o): string                       # option to transmit
    --quiet(-q)                                     # be more quiet
    --receive-pack: string                          # receive pack program
    --recurse-submodules: string                    # control recursive pushing of submodules
    --repo: string                                  # repository
    --set-upstream(-u)                              # set upstream for git pull/status
    --signed: string                                # GPG sign the push
    --tags                                          # push tags (can't be used with --all or --mirror)
    --thin                                          # use thin pack
    --verbose(-v)                                   # be more verbose
    --help                                          # Display this help message
  ]
}

# Get just the extern definitions without the custom completion commands
use completions *

# use C:\Users\marzouk\AppData\Roaming\nushell\winget-completions.nu *

# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html
let dark_theme = {
  # color for nushell primitives
  separator: white
  leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
  header: green_bold
  empty: blue
  bool: white
  int: white
  filesize: white
  duration: white
  date: white
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

  # shapes are used to change the cli syntax highlighting
  shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
  shape_binary: purple_bold
  shape_bool: light_cyan
  shape_int: purple_bold
  shape_float: purple_bold
  shape_range: yellow_bold
  shape_internalcall: cyan_bold
  shape_external: cyan
  shape_externalarg: green_bold
  shape_literal: blue
  shape_operator: yellow
  shape_signature: green_bold
  shape_string: green
  shape_string_interpolation: cyan_bold
  shape_datetime: cyan_bold
  shape_list: cyan_bold
  shape_table: blue_bold
  shape_record: cyan_bold
  shape_block: blue_bold
  shape_filepath: cyan
  shape_directory: cyan
  shape_globpattern: cyan_bold
  shape_variable: purple
  shape_flag: blue_bold
  shape_custom: green
  shape_nothing: light_cyan
  shape_matching_brackets: { attr: u }
}

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  filesize_metric: false # true => (KB, MB, GB), false => (KiB, MiB, GiB)
  table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: true
  rm_always_trash: true
  color_config: $dark_theme   # if you want a light theme, replace `$dark_theme` to `$light_theme`
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  quick_completions: true  # set this to false to prevent auto-selecting completions when only one remains
  partial_completions: true  # set this to false to prevent partial filling of the prompt
  completion_algorithm: "prefix"  # prefix, fuzzy
  float_precision: 2
  buffer_editor: "hx" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  edit_mode: emacs # emacs, vi
  max_history_size: 20000 # Session has to be reloaded for this to take effect
  sync_history_on_enter: true # Enable to share the history between multiple sessions, else you have to close the session to persist history to file
  history_file_format: "plaintext" # "sqlite" or "plaintext"
  shell_integration: false # enables terminal markers and a workaround to arrow keys stop working issue
  table_index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
  cd_with_abbreviations: true # set to true to allow you to do things like cd s/o/f and nushell expand it to cd some/other/folder
  case_sensitive_completions: false # set to true to enable case-sensitive completions
  enable_external_completion: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
  max_external_completion_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
  # A strategy of managing table view in case of limited space.
  table_trim: {
    methodology: wrapping, # truncating
    # A strategy which will be used by 'wrapping' methodology
    wrapping_try_keep_words: true,
    # A suffix which will be used with 'truncating' methodology
    # truncating_suffix: "..."
  }
  show_banner: false # true or false to enable or disable the banner
  show_clickable_links_in_ls: true # true or false to enable or disable clickable links in the ls listing. your terminal has to support links.
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

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
          text: green
          selected_text: green_reverse
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
          | where command =~ $buffer
          | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "V "
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
          | where command =~ $buffer
          | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: get_file_menu_nu_ui
        only_buffer_difference: true
        marker: "# "
        type: {
          layout: list
          page_size: 30
        }
        style: {
          text: "#000"
          selected_text: { fg: "#800000" attr: r }
          description_text: #66ff66
        }
        source: { |buffer, position|
          # ls | get name | where $it =~ $buffer
          fd --strip-cwd-prefix -H -t f -E .git -E node_modules | lines
          | where $it =~ $buffer
          | each { |it| { value: ($it | str trim) }}
        }
      }
  ]

  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs # Options: emacs vi_normal vi_insert
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
      name: redo_or_next_page
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          { send: menupagenext }
          { edit: redo }
        ]
      }
    }
    {
      name: redo_or_next_page
      modifier: 'control | shift'
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
      name: cut_current_line
      modifier: 'alt'
      keycode: char_r
      mode: emacs
      event: {
        until: [
          { edit: CutCurrentLine }
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

    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: control
      keycode: char_x
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_i
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
        # cmd: "cd (ls | where type == dir | each { |it| $it.name} | str collect (char nl) | fzf | decode utf-8 | str trim)"
        cmd: "cd (fd --strip-cwd-prefix --hidden --type directory --exclude .git --exclude node_modules | fzf)"
      }
    }
    {
      name: get_file_with_fzf
      modifier: 'control | shift'
      keycode: char_e
      mode: emacs
      event:[
        {
          edit: InsertString,
          value: "(fd --strip-cwd-prefix --hidden --type file --exclude .git --exclude node_modules | fzf | decode utf-8 | str trim)"
        }
        # { send: Enter }
      ]
    }
    {
      name: get_file_menu_nu_ui
      modifier: control
      keycode: char_f
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: get_file_menu_nu_ui }
    }
  ]
}

# Aliases
alias :q = exit
alias md = mkdir
alias pwd = $env.PWD
alias pwds = ($env.PWD | str replace $nu.home-path '~' -s)
alias v = nvim
alias l = lsd -l
alias ll = lsd -l
alias lg = lazygit
alias gs = gswin64c
alias ga = git add
alias gst = git status
alias gss = git status -s
alias gb = git branch --sort=committerdate
alias gci = (git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always | delta" | str trim | git checkout $in)
alias gd = git diff
alias gr = cd (git rev-parse --show-toplevel)
alias gg = git log --graph --pretty=format:'%C(bold red)%h%Creset -%C(bold green)%d%Creset %s %C(bold yellow)(%cr) %C(blue)%ad%Creset' --abbrev-commit --date=short
alias gloo = git log --pretty=format:'%C(yellow)%h %Cred%ad %Cgreen%d %Creset%s' --date=short
alias winconfig = git --git-dir=C:/Users/marzouk/.dotfiles --work-tree=C:/Users/marzouk
alias dotfiles = lazygit --git-dir=C:/Users/marzouk/.dotfiles --work-tree=C:/Users/marzouk
alias uptime = (sys).host.uptime
alias fs = (fd --strip-cwd-prefix -H -t f -E .git | fzf | str trim)
alias fp = (fd --strip-cwd-prefix -H -t f -E .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | str trim)
alias sl = (scoop list | lines | range 4.. | drop | split column -c ' ' | drop column | rename name version source updated | sort-by updated)

def fh [] {
  # let text = (history | reverse | get command | str collect (char nl) | fzf)
  let text = (history | reverse | get command | to text | fzf)
  kbsend -text $text -currentWindow -charDelay 0
}

def fe [] {
  # let file = (fd --strip-cwd-prefix -H -t f -E .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | decode utf-8 | str trim)
  let file = (fd --strip-cwd-prefix -H -e txt -e json -e js -e jsx -e ts -e tsx -e css -e html -e md -e lua | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | decode utf-8 | str trim)
  if ($file != '') {
    nvim $file
  }
}

def fm [] {
  let file = (fd --strip-cwd-prefix -e mp4 -e webm -e mkv -e gif | fzf | decode utf-8 | str trim)
  if ($file != '') {
    mpv $file
  }
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
  if ($reverse | is-empty) || (not $reverse) {
    # ls | sort-by modified | reject type
    ls | sort-by modified | select name size modified
  } else {
    ls | sort-by modified -r | select name size modified
  }
}

# ls by type
def lt [] {
  ls | sort-by type name | select name size modified
}

# ls sorted by extension
def le [] {
  ls | sort-by -i type name | insert ext { $in.name | path parse | get extension } | sort-by ext | reject ext type
}

# search for specific process
def psn [name: string] {
  ps | find $name
}

# kill specified process in name
def killn [name: string] {
  ps | find $name | each {kill -f $in.pid}
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
    which ($terms | first) | any { |it| $it.built-in || $it.path =~ ^Nushell }
  ) {
    help ($terms | str collect " ")
  } else {
    tldr ($terms | str collect "-")
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
  let s = (sys)
  print $"(ansi reset)(ansi green)($ellie.0)"
  print $"(ansi green)($ellie.1)  (ansi yellow) (ansi yellow_bold)Nushell (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
  print $"(ansi green)($ellie.2)  (ansi light_blue) (ansi light_blue_bold)RAM (ansi reset)(ansi light_blue)($s.mem.used) / ($s.mem.total)(ansi reset)"
  print $"(ansi green)($ellie.3)  (ansi light_purple)ﮫ (ansi light_purple_bold)Uptime (ansi reset)(ansi light_purple)($s.host.uptime)(ansi reset)"
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
def h [n = 100] {
  history | last $n | update command { |f| $f.command | nu-highlight }
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
    let to_translate = ($search | str collect "%20")
    let url = $"https://api.mymemory.translated.net/get?q=($to_translate)&langpair=($from)%7C($to)"

    fetch $url
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

# go up n directories
def-env up [nb: int = 1] {
  let path = (1..$nb | each {|_| ".."} | reduce {|it, acc| $acc + "\\" + $it})
  cd $path
}

# make and cd into a directory
def-env mcd [name: path] {
  cd (mkdir $name -s | first)
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

# scripts
source ~/Appdata/Roaming/nushell/scripts/dict.nu
source ~/Appdata/Roaming/nushell/scripts/format-number.nu
source ~/Appdata/Roaming/nushell/scripts/nu-sloc.nu

### starship config
source ~/.cache/starship/init-temp.nu

### zoxide config
source ~/.zoxide.nu
