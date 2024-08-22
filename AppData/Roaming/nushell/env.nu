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
      $" (ansi xterm_mediumpurple2a)($content | split words | last)"
    } else {
      $" (ansi xterm_mediumpurple2a)($content | str substring ..7)"
    }
  } else {
    ""
  }

  print ([$path_segment, $exit_code_segment, $git_branch_segment, $duration_segment] | str join)
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

# The prompt indicators are environmental variables that represent
# the state of the prompt
# $env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR = " ➜ "
$env.PROMPT_INDICATOR_VI_INSERT = " : "
$env.PROMPT_INDICATOR_VI_NORMAL = " 〉"
$env.PROMPT_MULTILINE_INDICATOR = " ::: "

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
  ($nu.data-dir | path join 'completions') # default home for nushell completions
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
# $env.BOOKMARK_MANAGER_CSV = $"($nu.home-path)/documents/bm/bm.csv"
$env.LESS = '--quiet'
$env.MOAR = '--no-statusbar --style=github-dark'
$env.PAGER = 'moar --no-linenumbers -quit-if-one-screen'
# vivid generate tokyonight-night
$env.LS_COLORS = "*~=0;38;2;65;72;104:bd=1;38;2;247;118;142;48;2;45;26;39:ca=0;48;2;40;52;87:cd=1;38;2;224;175;104;48;2;45;36;36:di=0;38;2;122;162;247:do=1;38;2;158;206;106;48;2;32;41;37:ex=1;38;2;158;206;106:fi=0:ln=3;38;2;137;221;255:mh=0:mi=0;38;2;219;75;75:no=0;38;2;86;95;137:or=0;38;2;26;27;38;48;2;219;75;75:ow=1;38;2;122;162;247;48;2;40;52;87:pi=1;38;2;255;158;100;48;2;49;32;37:rs=0;38;2;86;95;137:sg=0;48;2;40;52;87:so=1;38;2;26;188;156;48;2;26;41;45:st=0;48;2;40;52;87:su=0;48;2;40;52;87:tw=1;38;2;26;27;38;48;2;122;162;247:*.a=0;38;2;26;188;156:*.c=0;38;2;224;175;104:*.d=0;38;2;224;175;104:*.h=0;38;2;224;175;104:*.m=0;38;2;224;175;104:*.o=0;38;2;65;72;104:*.p=0;38;2;224;175;104:*.r=0;38;2;224;175;104:*.t=0;38;2;224;175;104:*.z=1;38;2;247;118;142:*.7z=1;38;2;247;118;142:*.as=0;38;2;224;175;104:*.bc=0;38;2;65;72;104:*.bz=1;38;2;247;118;142:*.cc=0;38;2;224;175;104:*.cp=0;38;2;224;175;104:*.cr=0;38;2;224;175;104:*.cs=0;38;2;224;175;104:*.di=0;38;2;224;175;104:*.el=0;38;2;224;175;104:*.ex=0;38;2;224;175;104:*.fs=0;38;2;224;175;104:*.go=0;38;2;224;175;104:*.gv=0;38;2;224;175;104:*.gz=1;38;2;247;118;142:*.hh=0;38;2;224;175;104:*.hi=0;38;2;65;72;104:*.hs=0;38;2;224;175;104:*.jl=0;38;2;224;175;104:*.js=0;38;2;224;175;104:*.ko=0;38;2;26;188;156:*.kt=0;38;2;224;175;104:*.la=0;38;2;65;72;104:*.ll=0;38;2;224;175;104:*.lo=0;38;2;65;72;104:*.md=0;38;2;192;202;245:*.ml=0;38;2;224;175;104:*.mn=0;38;2;224;175;104:*.nb=0;38;2;224;175;104:*.pl=0;38;2;224;175;104:*.pm=0;38;2;224;175;104:*.pp=0;38;2;224;175;104:*.ps=1;38;2;187;154;247:*.py=0;38;2;224;175;104:*.rb=0;38;2;224;175;104:*.rm=1;38;2;115;218;202:*.rs=0;38;2;224;175;104:*.sh=0;38;2;224;175;104:*.so=0;38;2;26;188;156:*.td=0;38;2;224;175;104:*.ts=0;38;2;224;175;104:*.ui=0;38;2;255;158;100:*.vb=0;38;2;224;175;104:*.wv=1;38;2;13;185;215:*.xz=1;38;2;247;118;142:*.aif=1;38;2;13;185;215:*.ape=1;38;2;13;185;215:*.apk=1;38;2;247;118;142:*.arj=1;38;2;247;118;142:*.asa=0;38;2;224;175;104:*.aux=0;38;2;65;72;104:*.avi=1;38;2;115;218;202:*.awk=0;38;2;224;175;104:*.bag=1;38;2;247;118;142:*.bak=0;38;2;65;72;104:*.bat=0;38;2;26;188;156:*.bbl=0;38;2;65;72;104:*.bcf=0;38;2;65;72;104:*.bib=0;38;2;255;158;100:*.bin=1;38;2;247;118;142:*.blg=0;38;2;65;72;104:*.bmp=1;38;2;157;124;216:*.bsh=0;38;2;224;175;104:*.bst=0;38;2;255;158;100:*.bz2=1;38;2;247;118;142:*.c++=0;38;2;224;175;104:*.cfg=0;38;2;255;158;100:*.cgi=0;38;2;224;175;104:*.clj=0;38;2;224;175;104:*.com=0;38;2;26;188;156:*.cpp=0;38;2;224;175;104:*.css=0;38;2;224;175;104:*.csv=0;38;2;192;202;245:*.csx=0;38;2;224;175;104:*.cxx=0;38;2;224;175;104:*.deb=1;38;2;247;118;142:*.def=0;38;2;224;175;104:*.dll=0;38;2;26;188;156:*.dmg=1;38;2;247;118;142:*.doc=1;38;2;187;154;247:*.dot=0;38;2;224;175;104:*.dox=0;38;2;13;185;215:*.dpr=0;38;2;224;175;104:*.elc=0;38;2;224;175;104:*.elm=0;38;2;224;175;104:*.epp=0;38;2;224;175;104:*.eps=1;38;2;157;124;216:*.erl=0;38;2;224;175;104:*.exe=0;38;2;26;188;156:*.exs=0;38;2;224;175;104:*.fls=0;38;2;65;72;104:*.flv=1;38;2;115;218;202:*.fnt=1;38;2;26;188;156:*.fon=1;38;2;26;188;156:*.fsi=0;38;2;224;175;104:*.fsx=0;38;2;224;175;104:*.gif=1;38;2;157;124;216:*.git=0;38;2;65;72;104:*.gvy=0;38;2;224;175;104:*.h++=0;38;2;224;175;104:*.hpp=0;38;2;224;175;104:*.htc=0;38;2;224;175;104:*.htm=0;38;2;192;202;245:*.hxx=0;38;2;224;175;104:*.ico=1;38;2;157;124;216:*.ics=1;38;2;187;154;247:*.idx=0;38;2;65;72;104:*.ilg=0;38;2;65;72;104:*.img=1;38;2;247;118;142:*.inc=0;38;2;224;175;104:*.ind=0;38;2;65;72;104:*.ini=0;38;2;255;158;100:*.inl=0;38;2;224;175;104:*.ipp=0;38;2;224;175;104:*.iso=1;38;2;247;118;142:*.jar=1;38;2;247;118;142:*.jpg=1;38;2;157;124;216:*.kex=1;38;2;187;154;247:*.kts=0;38;2;224;175;104:*.log=0;38;2;65;72;104:*.ltx=0;38;2;224;175;104:*.lua=0;38;2;224;175;104:*.m3u=1;38;2;13;185;215:*.m4a=1;38;2;13;185;215:*.m4v=1;38;2;115;218;202:*.mid=1;38;2;13;185;215:*.mir=0;38;2;224;175;104:*.mkv=1;38;2;115;218;202:*.mli=0;38;2;224;175;104:*.mov=1;38;2;115;218;202:*.mp3=1;38;2;13;185;215:*.mp4=1;38;2;115;218;202:*.mpg=1;38;2;115;218;202:*.nix=0;38;2;255;158;100:*.odp=1;38;2;187;154;247:*.ods=1;38;2;187;154;247:*.odt=1;38;2;187;154;247:*.ogg=1;38;2;13;185;215:*.org=0;38;2;192;202;245:*.otf=1;38;2;26;188;156:*.out=0;38;2;65;72;104:*.pas=0;38;2;224;175;104:*.pbm=1;38;2;157;124;216:*.pdf=1;38;2;187;154;247:*.pgm=1;38;2;157;124;216:*.php=0;38;2;224;175;104:*.pid=0;38;2;65;72;104:*.pkg=1;38;2;247;118;142:*.png=1;38;2;157;124;216:*.pod=0;38;2;224;175;104:*.ppm=1;38;2;157;124;216:*.pps=1;38;2;187;154;247:*.ppt=1;38;2;187;154;247:*.pro=0;38;2;13;185;215:*.ps1=0;38;2;224;175;104:*.psd=1;38;2;157;124;216:*.pyc=0;38;2;65;72;104:*.pyd=0;38;2;65;72;104:*.pyo=0;38;2;65;72;104:*.rar=1;38;2;247;118;142:*.rpm=1;38;2;247;118;142:*.rst=0;38;2;192;202;245:*.rtf=1;38;2;187;154;247:*.sbt=0;38;2;224;175;104:*.sql=0;38;2;224;175;104:*.sty=0;38;2;65;72;104:*.svg=1;38;2;157;124;216:*.swf=1;38;2;115;218;202:*.swp=0;38;2;65;72;104:*.sxi=1;38;2;187;154;247:*.sxw=1;38;2;187;154;247:*.tar=1;38;2;247;118;142:*.tbz=1;38;2;247;118;142:*.tcl=0;38;2;224;175;104:*.tex=0;38;2;224;175;104:*.tgz=1;38;2;247;118;142:*.tif=1;38;2;157;124;216:*.tml=0;38;2;255;158;100:*.tmp=0;38;2;65;72;104:*.toc=0;38;2;65;72;104:*.tsx=0;38;2;224;175;104:*.ttf=1;38;2;26;188;156:*.txt=0;38;2;192;202;245:*.vcd=1;38;2;247;118;142:*.vim=0;38;2;224;175;104:*.vob=1;38;2;115;218;202:*.wav=1;38;2;13;185;215:*.wma=1;38;2;13;185;215:*.wmv=1;38;2;115;218;202:*.xcf=1;38;2;157;124;216:*.xlr=1;38;2;187;154;247:*.xls=1;38;2;187;154;247:*.xml=0;38;2;192;202;245:*.xmp=0;38;2;255;158;100:*.yml=0;38;2;255;158;100:*.zip=1;38;2;247;118;142:*.zsh=0;38;2;224;175;104:*.zst=1;38;2;247;118;142:*TODO=1;38;2;180;249;248:*hgrc=0;38;2;13;185;215:*.bash=0;38;2;224;175;104:*.conf=0;38;2;255;158;100:*.dart=0;38;2;224;175;104:*.diff=0;38;2;224;175;104:*.docx=1;38;2;187;154;247:*.epub=1;38;2;187;154;247:*.fish=0;38;2;224;175;104:*.flac=1;38;2;13;185;215:*.h264=1;38;2;115;218;202:*.hgrc=0;38;2;13;185;215:*.html=0;38;2;192;202;245:*.java=0;38;2;224;175;104:*.jpeg=1;38;2;157;124;216:*.json=0;38;2;255;158;100:*.less=0;38;2;224;175;104:*.lisp=0;38;2;224;175;104:*.lock=0;38;2;65;72;104:*.make=0;38;2;13;185;215:*.mpeg=1;38;2;115;218;202:*.opus=1;38;2;13;185;215:*.orig=0;38;2;65;72;104:*.pptx=1;38;2;187;154;247:*.psd1=0;38;2;224;175;104:*.psm1=0;38;2;224;175;104:*.purs=0;38;2;224;175;104:*.rlib=0;38;2;65;72;104:*.sass=0;38;2;224;175;104:*.scss=0;38;2;224;175;104:*.tbz2=1;38;2;247;118;142:*.tiff=1;38;2;157;124;216:*.toml=0;38;2;255;158;100:*.webm=1;38;2;115;218;202:*.webp=1;38;2;157;124;216:*.woff=1;38;2;26;188;156:*.xbps=1;38;2;247;118;142:*.xlsx=1;38;2;187;154;247:*.yaml=0;38;2;255;158;100:*.cabal=0;38;2;224;175;104:*.cache=0;38;2;65;72;104:*.class=0;38;2;65;72;104:*.cmake=0;38;2;13;185;215:*.dyn_o=0;38;2;65;72;104:*.ipynb=0;38;2;224;175;104:*.mdown=0;38;2;192;202;245:*.patch=0;38;2;224;175;104:*.scala=0;38;2;224;175;104:*.shtml=0;38;2;192;202;245:*.swift=0;38;2;224;175;104:*.toast=1;38;2;247;118;142:*.xhtml=0;38;2;192;202;245:*README=1;38;2;125;207;255:*passwd=0;38;2;255;158;100:*shadow=0;38;2;255;158;100:*.config=0;38;2;255;158;100:*.dyn_hi=0;38;2;65;72;104:*.flake8=0;38;2;13;185;215:*.gradle=0;38;2;224;175;104:*.groovy=0;38;2;224;175;104:*.ignore=0;38;2;13;185;215:*.matlab=0;38;2;224;175;104:*COPYING=1;38;2;192;202;245:*INSTALL=1;38;2;125;207;255:*LICENSE=1;38;2;192;202;245:*TODO.md=1;38;2;180;249;248:*.desktop=0;38;2;255;158;100:*.gemspec=0;38;2;13;185;215:*Doxyfile=0;38;2;13;185;215:*Makefile=0;38;2;13;185;215:*TODO.txt=1;38;2;180;249;248:*setup.py=0;38;2;13;185;215:*.DS_Store=0;38;2;65;72;104:*.cmake.in=0;38;2;13;185;215:*.fdignore=0;38;2;13;185;215:*.kdevelop=0;38;2;13;185;215:*.markdown=0;38;2;192;202;245:*.rgignore=0;38;2;13;185;215:*COPYRIGHT=1;38;2;192;202;245:*README.md=1;38;2;125;207;255:*configure=0;38;2;13;185;215:*.gitconfig=0;38;2;13;185;215:*.gitignore=0;38;2;13;185;215:*.localized=0;38;2;65;72;104:*.scons_opt=0;38;2;65;72;104:*CODEOWNERS=0;38;2;13;185;215:*Dockerfile=0;38;2;65;166;181:*INSTALL.md=1;38;2;125;207;255:*README.txt=1;38;2;125;207;255:*SConscript=0;38;2;13;185;215:*SConstruct=0;38;2;13;185;215:*.gitmodules=0;38;2;13;185;215:*.synctex.gz=0;38;2;65;72;104:*.travis.yml=0;38;2;65;166;181:*INSTALL.txt=1;38;2;125;207;255:*LICENSE-MIT=1;38;2;192;202;245:*MANIFEST.in=0;38;2;13;185;215:*Makefile.am=0;38;2;13;185;215:*Makefile.in=0;38;2;65;72;104:*.applescript=0;38;2;224;175;104:*.fdb_latexmk=0;38;2;65;72;104:*CONTRIBUTORS=1;38;2;125;207;255:*appveyor.yml=0;38;2;65;166;181:*configure.ac=0;38;2;13;185;215:*.clang-format=0;38;2;13;185;215:*.gitattributes=0;38;2;13;185;215:*.gitlab-ci.yml=0;38;2;65;166;181:*CMakeCache.txt=0;38;2;65;72;104:*CMakeLists.txt=0;38;2;13;185;215:*LICENSE-APACHE=1;38;2;192;202;245:*CONTRIBUTORS.md=1;38;2;125;207;255:*.sconsign.dblite=0;38;2;65;72;104:*CONTRIBUTORS.txt=1;38;2;125;207;255:*requirements.txt=0;38;2;13;185;215:*package-lock.json=0;38;2;65;72;104:*.CFUserTextEncoding=0;38;2;65;72;104"


### zoxide config
# zoxide init nushell | save -f ~/.cache/.zoxide.nu

### starship config
# starship init nu | save -f ~/.cache/starship/init.nu

### oh-my-posh config
# oh-my-posh init nu --config ~/.config/.pure-theme.omp.json
