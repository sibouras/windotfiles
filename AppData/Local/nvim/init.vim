call plug#begin(stdpath('data'))

" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'ggandor/lightspeed.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jiangmiao/auto-pairs'
Plug 'ThePrimeagen/vim-be-good'
Plug 'junegunn/vim-easy-align'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vimwiki/vimwiki'
Plug 'dstein64/vim-startuptime'
Plug 'sheerun/vim-polyglot'
Plug 'romainl/vim-cool'
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'honza/vim-snippets'
" Plug 'mattn/emmet-vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'tamago324/lir.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'jdhao/better-escape.vim'

call plug#end()

cd ~
set encoding=utf-8
set fileencoding=utf-8      " The encoding written to file
syntax on
colorscheme onedark
if !has('gui_running')
  set t_Co=256
endif

" set guifont=JetBrains\ Mono\ for\ Powerline:h16
set guifont=JetbrainsMono\ Nerd\ Font:h16
" set guifont=DejaVuSansMono\ nerd\ Font\ Mono:h16

" set nonumber norelativenumber
" set lines=140
" set columns=120

set splitbelow              " Horizontal splits will automatically be below
set splitright              " Vertical splits will automatically be to the right
" set showtabline=2           " Always show tabs
set cmdheight=2             " More space for displaying messages
set formatoptions-=cro      " Stop newline continution of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set nowrap                  " Display long lines as just one line
set ruler                   " Show the cursor position all the time
set cmdheight=2             " More space for displaying messages
set mouse=a                 " Enable your mouse
set smarttab                " Makes tabbing smarter will realize you have 2 vs 4
set expandtab               " Converts tabs to spaces
set updatetime=300          " Faster completion
set timeoutlen=300          " By default timeoutlen is 1000 ms
set cursorline
set scrolloff=4
set sidescrolloff=5
set number                  " Enable Line number
set relativenumber          " relative number
set tabstop=2 softtabstop=2 " tab size
set shiftwidth=2            " shift width
set hidden                  " Needed to keep multiple buffers open
set nobackup                " No auto backups
set noswapfile              " No swap
set clipboard=unnamedplus   " Copy/paste between vim and other programs.
set wildmenu                " show wildmenu
set linebreak               " do not break words.
set incsearch
set pastetoggle=<F2>        " enable paste mode
set ignorecase
set smartcase
set autoindent
set smartindent
set cindent
set inccommand=split        " live Substitution


" set leader key
let mapleader = " "

" Start new line
inoremap <S-Return> <C-o>o

" Use alt + hjkl to resize windows
" nnoremap <M-j>    :resize -2<CR>
" nnoremap <M-k>    :resize +2<CR>
" nnoremap <M-h>    :vertical resize -2<CR>
" nnoremap <M-l>    :vertical resize +2<CR>

" arrow keys resize windows
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Remove spaces at the end of lines
" nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" I hate escape more than anything else
" inoremap df <Esc>
" inoremadp jf <Esc>
let g:better_escape_interval = 150
let g:better_escape_shortcut = 'df'

" ctrl-z to undo
inoremap <c-z> <c-o>:u<CR>

" Fast saving
nnoremap <C-s> :<C-u>w<CR>
vnoremap <C-s> :<C-u>w<CR>
cnoremap <C-s> <C-u>w<CR>

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>
cmap <C-BS> <C-W>

" clears highlights
" nnoremap <leader>sc :noh<return>

" open vimrc in vertical split
nnoremap <leader>mv :vsplit $MYVIMRC<cr>
" update changes into current buffer
" nnoremap <leader>sv :source $MYVIMRC<cr>

" Now pressing \b will list the available buffers and prepare :b for you.
" nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader><tab> <C-^>
nnoremap <M-w> <C-^>
inoremap <M-w> <esc><C-^>

" the following command maps the <F4> key to display the current date and time.
:map <F4> :echo 'Current time is ' . strftime('%c')<CR>

" The following command maps the <F3> key to insert the current date and time in the current buffer:
:map! <F3> <C-R>=strftime('%c')<CR>

" The following command maps <F2> to insert the directory name of the current buffer:
:inoremap <F2> <C-R>=expand('%:p:h')<CR>

" change directory to the file being edited and  print the directory after changing
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" working directory is always the same as the file you are editing
" startify conflict with session
autocmd BufEnter * silent! lcd %:p:h

" the following command maps the <F5> key to search for the keyword under the cursor in the current directory using the 'grep' command:
:nnoremap <F5> :grep <C-R><C-W> *<CR>

" Automatically removing all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" line text object
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>
xnoremap i% GoggV
onoremap i% :normal vi%<CR>

" shorter replace
" nnoremap <leader>s :%s//gI<Left><Left><Left>

" make Y behave like the rest of the capital letters
nnoremap Y y$

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" jumplit mutations
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'

" moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" keep the cursor in place
nnoremap }   }zz
nnoremap {   {zz
nnoremap ]]  ]]zz
nnoremap [[  [[zz
nnoremap []  []zz
nnoremap ][  ][zz

nnoremap g;  g;zvzz
nnoremap g,  g,zvzz

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Fix gx for URLs
nmap <silent> gx yiW:!start brave <C-r>" & <CR><CR>
vmap <silent> gx y:!start brave <C-r>" & <CR><CR>

" Make tab and shift tab navigate autocomplete menus
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neovim built in terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>te :sp term://powershell<CR>
tnoremap df <C-\><C-n>
tnoremap <C-k> <C-\><C-n><C-w>k


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment to autostart the NERDTree
"" autocmd vimenter * NERDTree
" map <C-n> :NERDTreeToggle<CR>
" let g:NERDTreeDirArrowExpandable = '►'
" let g:NERDTreeDirArrowCollapsible = '▼'
" let NERDTreeShowLineNumbers=1
" let NERDTreeShowHidden=1
" let NERDTreeMinimalUI = 1
" let g:NERDTreeWinSize=28

" close netrw buffer
let g:netrw_fastbrowse = 0

" neovim built in yank highlight
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Theming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight Normal             guibg=#1e222a
" highlight Normal           guifg=#dfdfdf ctermfg=15   guibg=#282c34 ctermbg=none  cterm=none
" highlight LineNr           guifg=#5b6268 ctermfg=8    guibg=#282c34 ctermbg=none  cterm=none
" highlight CursorLineNr     guibg=#2c323c ctermfg=7    guifg=#aaaaaa ctermbg=8     cterm=none
" highlight VertSplit        guifg=#1c1f24 ctermfg=0    guifg=#5b6268 ctermbg=8     cterm=none
" highlight Statement        guifg=#98be65 ctermfg=2    guibg=none    ctermbg=none  cterm=none
" highlight Directory        guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
" highlight StatusLine       guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
" highlight StatusLineNC     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
" highlight NERDTreeClosable guifg=#98be65 ctermfg=2
" highlight NERDTreeOpenable guifg=#5b6268 ctermfg=8
" highlight Comment          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=italic
" highlight Constant         guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
" highlight Special          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
" highlight Identifier       guifg=#5699af ctermfg=6    guibg=none    ctermbg=none  cterm=none
" highlight PreProc          guifg=#c678dd ctermfg=5    guibg=none    ctermbg=none  cterm=none
" highlight String           guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
" highlight Number           guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
" highlight Function         guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
" highlight Visual           guifg=#dfdfdf ctermfg=1    guibg=#1c1f24 ctermbg=none  cterm=none


" Replacing grep with rg
set grepprg=rg\ --vimgrep\ --smart-case\ --follow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Easy Align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" easy align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ctrlp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>b :CtrlPBuffer<CR>
" Exclude files or directories using Vim's wildignore
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
" And/Or CtrlP's own g:ctrlp_custom_ignore
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" A simple function for zooming in GUI version of Vim/Neovim
" Increases the font size with `amount`
function! Zoom(amount) abort
  call ZoomSet(matchstr(&guifont, '\d\+$') + a:amount)
endfunc

" Sets the font size to `font_size`
function ZoomSet(font_size) abort
  let &guifont = substitute(&guifont, '\d\+$', a:font_size, '')
endfunc

noremap <silent> <M-=> :call Zoom(v:count1)<CR>
noremap <silent> <M--> :call Zoom(-v:count1)<CR>
noremap <silent> <M-0> :call ZoomSet(11)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{
  \ 'path': '~/vimwiki',
  \ 'path_html': 'C:/Users/marzouk/vimwiki_html',
  \ 'template_path': '~/vimwiki/templates',
  \ 'template_default': 'syntaxhl',
  \ 'template_ext': '.tpl'}]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Clap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:clap_theme = 'onedark'
" " nnoremap <silent> <Leader>f  :Clap filer<CR>
" nnoremap <silent> <Leader>r  :Clap grep<CR>
" nnoremap <silent> <Leader>/  :Clap blines<CR>
" nnoremap <silent> <Leader>'  :Clap marks<CR>
" nnoremap <silent> <Leader>g  :Clap commits<CR>
" nnoremap <silent> <Leader>hh :Clap history<CR>
" nnoremap <silent> <Leader>h: :Clap hist:<CR>
" nnoremap <silent> <Leader>h/ :Clap hist/<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => startify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>s  :Startify<CR>
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   Current Directory '] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]

let g:startify_bookmarks = [
      \ { 'i': '~/AppData/Local/nvim/init.vim' },
      \ { 'v': '~/AppData/Roaming/code/User/settings.json' },
      \ { 'w': 'C:/tools/komorebi/komorebi.ahk' },
      \ { 'h': '~/' },
      \ { 'a': '~/autohotkey' },
      \ { 'c': '~/code' },
      \ '~/documents',
      \ ]

let g:startify_change_to_dir = 1
let g:startify_session_autoload = 1
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
let g:startify_session_persistence = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" source $HOME/AppData/Local/nvim/coc.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => emmet-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:user_emmet_mode='a'    "enable all function in all mode.
" let g:user_emmet_leader_key=','
" " Enable just for html/css/js
" let g:user_emmet_install_global = 0
" autocmd FileType html,css,javascript EmmetInstall
" let g:user_emmet_settings = {
" \  'javascript' : {
" \      'extends' : 'jsx',
" \  },
" \}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => barbar.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
inoremap <silent>    <A-,> <esc>:BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
inoremap <silent>    <A-.> <esc>:BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-S-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A-S->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <A-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neoscroll.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('neoscroll').setup({
    hide_cursor = true,           -- Hide cursor while scrolling
    easing_function = "quadratic" -- Default easing function
    -- Set any other options as needed
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250', [['sine']]}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '250', [['sine']]}}
-- Use the "shine" easing function
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '400', [['shine']]}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '400', [['shine']]}}
-- Pass "nil" to disable the easing animation (constant scrolling speed)
t['<C-y>'] = {'scroll', {'-0.10', 'false', '80', nil}}
t['<C-e>'] = {'scroll', { '0.10', 'false', '80', nil}}
-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t['zt']    = {'zt', {'100'}}
t['zz']    = {'zz', {'100'}}
t['zb']    = {'zb', {'100'}}

require('neoscroll.config').set_mappings(t)
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lir.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>f :lua require'lir.float'.toggle()<CR>
lua << EOF
local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<cr>']  = actions.edit,
    ['<c-s>'] = actions.split,
		['<c-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h']     = actions.up,
    ['q']     = actions.quit,
    ['<esc>'] = actions.quit,

    ['A']     = actions.mkdir,
    ['a']     = actions.newfile,
    ['r']     = actions.rename,
    ['@']     = actions.cd,
    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['d']     = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,

    -- -- You can define a function that returns a table to be passed as the third
    -- -- argument of nvim_open_win().
    win_opts = function()
    --   local width = math.floor(vim.o.columns * 0.8)
    --   local height = math.floor(vim.o.lines * 0.8)
      return {
    --    border = "single",
        border = require("lir.float.helper").make_border_opts({
          "+", "─", "+", "│", "+", "─", "+", "│",
        }, "Normal"),
    --     width = width,
    --     height = height,
    --     row = 1,
    --     col = math.floor((vim.o.columns - width) / 2),
      }
    end,
  },
  hide_cursor = true,
}

-- custom folder icon
require'nvim-web-devicons'.setup({
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode"
    },
  }
})

-- use visual mode
function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>', {noremap = true, silent = true})

  -- echo cwd
  vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]
EOF
