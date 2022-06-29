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

  export extern "git checkout" [
    branch?: string@"nu-complete git branches" # name of the branch to checkout
    -b: string                                 # create and checkout a new branch
    -B: string                                 # create/reset and checkout a branch
    -l                                         # create reflog for new branch
    --guess                                    # second guess 'git checkout <no-such-branch>' (default)
    --overlay                                  # use overlay mode (default)
    --quiet(-q)                                # suppress progress reporting
    --recurse-submodules: string               # control recursive updating of submodules
    --progress                                 # force progress reporting
    --merge(-m)                                # perform a 3-way merge with the new branch
    --conflict: string                         # conflict style (merge or diff3)
    --detach(-d)                               # detach HEAD at named commit
    --track(-t)                                # set upstream info for new branch
    --force(-f)                                # force checkout (throw away local modifications)
    --orphan: string                           # new unparented branch
    --overwrite-ignore                         # update ignored files (default)
    --ignore-other-worktrees                   # do not check if another worktree is holding the given ref
    --ours(-2)                                 # checkout our version for unmerged files
    --theirs(-3)                               # checkout their version for unmerged files
    --patch(-p)                                # select hunks interactively
    --ignore-skip-worktree-bits                # do not limit pathspecs to sparse entries only
    --pathspec-from-file: string               # read pathspec from file
  ]

  export extern "git push" [
    remote?: string@"nu-complete git remotes", # the name of the remote
    refspec?: string@"nu-complete git branches"# the branch / refspec
    --verbose(-v)                              # be more verbose
    --quiet(-q)                                # be more quiet
    --repo: string                             # repository
    --all                                      # push all refs
    --mirror                                   # mirror all refs
    --delete(-d)                               # delete refs
    --tags                                     # push tags (can't be used with --all or --mirror)
    --dry-run(-n)                              # dry run
    --porcelain                                # machine-readable output
    --force(-f)                                # force updates
    --force-with-lease: string                 # require old value of ref to be at this value
    --recurse-submodules: string               # control recursive pushing of submodules
    --thin                                     # use thin pack
    --receive-pack: string                     # receive pack program
    --exec: string                             # receive pack program
    --set-upstream(-u)                         # set upstream for git pull/status
    --progress                                 # force progress reporting
    --prune                                    # prune locally removed refs
    --no-verify                                # bypass pre-push hook
    --follow-tags                              # push missing but relevant tags
    --signed: string                           # GPG sign the push
    --atomic                                   # request atomic transaction on remote side
    --push-option(-o): string                  # option to transmit
    --ipv4(-4)                                 # use IPv4 addresses only
    --ipv6(-6)                                 # use IPv6 addresses only
  ]
}

# Get just the extern definitions without the custom completion commands
use completions *

# use C:\Users\marzouk\AppData\Roaming\nushell\winget-completions.nu *

# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html
let default_theme = {
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
    shape_globpattern: cyan_bold
    shape_variable: purple
    shape_flag: blue_bold
    shape_custom: green
    shape_nothing: light_cyan
}

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  # completion_algorithm: "fuzzy"
  buffer_editor: nvim
  filesize_metric: false
  table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: true
  rm_always_trash: false
  color_config: $default_theme
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  quick_completions: false  # set this to false to prevent auto-selecting completions when only one remains
  partial_completions: true  # set this to false to prevent partial filling of the prompt
  animate_prompt: false # redraw the prompt every second
  float_precision: 2
  use_ansi_coloring: true
  filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  edit_mode: emacs # emacs, vi
  max_history_size: 10000 # Session has to be reloaded for this to take effect
  sync_history_on_enter: true # Enable to share the history between multiple sessions, else you have to close the session to persist history to file

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
alias pwd = $env.PWD
alias pwds = ($env.PWD | str replace $nu.home-path '~' -s)
alias v = nvim
alias l = lsd -l
alias ll = lsd -l
alias lg = lazygit
alias ga = git add
alias gst = git status
alias gss = git status -s
alias gb = git branch
alias gd = git diff
alias gr = cd (git rev-parse --show-toplevel)
alias gg = git log --graph --pretty=format:'%C(bold red)%h%Creset -%C(bold green)%d%Creset %s %C(bold yellow)(%cr) %C(blue)%ad%Creset' --abbrev-commit --date=short
alias gloo = git log --pretty=format:'%C(yellow)%h %Cred%ad %Cgreen%d %Creset%s' --date=short
alias winconfig = git --git-dir=C:/Users/marzouk/.dotfiles --work-tree=C:/Users/marzouk
alias dotfiles = lazygit --git-dir=C:/Users/marzouk/.dotfiles --work-tree=C:/Users/marzouk
alias uptime = (sys).host.uptime
alias fs = (fd --strip-cwd-prefix -H -t f -E .git | fzf | str trim)
alias fp = (fd --strip-cwd-prefix -H -t f -E .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | str trim)

def fh [] {
  let text = (history | reverse | get command | str collect (char nl) | fzf)
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
def get-aliases [] {
  open $nu.config-path | lines | find alias | find -v aliases | split column '=' | select column1 column2 | rename Alias Command | update Alias {|f| $f.Alias | split row ' ' | last} | sort-by Alias
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

### starship config
source ~/.cache/starship/init.nu

### zoxide config
source ~/.zoxide.nu
