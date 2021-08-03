call plug#begin(stdpath('data'))

Plug 'scrooloose/nerdtree'
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'ThePrimeagen/vim-be-good'
Plug 'junegunn/vim-easy-align'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vimwiki/vimwiki'
Plug 'dstein64/vim-startuptime'

call plug#end()

set encoding=utf-8
set fileencoding=utf-8      " The encoding written to file
syntax on
colorscheme onedark
if !has('gui_running')
  set t_Co=256
endif

set guifont=JetBrains\ Mono\ for\ Powerline:h16
" set guifont=DejaVuSansMono\ nerd\ Font\ Mono:h23

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
set timeoutlen=200          " By default timeoutlen is 1000 ms
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
" indent
set autoindent
set smartindent
set cindent


" set leader key
let mapleader = " "

" Start new line
inoremap <S-Return> <C-o>o

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
			\ 'zt' : (winline() == &scrolloff + 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
			\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "H")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
			\ ."\<C-u>".(line('w0') <= 1 ? "H" : "L")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "2\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "2\<C-y>")


" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Remove spaces at the end of lines
" nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" I hate escape more than anything else
inoremap df <Esc>

" Fast saving
nnoremap <C-s> :<C-u>w<CR>
vnoremap <C-s> :<C-u>w<CR>
cnoremap <C-s> <C-u>w<CR>

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>
cmap <C-BS> <C-W>

"clears highlights
nnoremap <leader>sc :noh<return>

" open vimrc in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" update changes into current buffer
nnoremap <leader>sv :source $MYVIMRC<cr>

" Now pressing \b will list the available buffers and prepare :b for you.
" nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader><tab> <C-^>

" the following command maps the <F4> key to display the current date and time.
:map <F4> :echo 'Current time is ' . strftime('%c')<CR>

" The following command maps the <F3> key to insert the current date and time in the current buffer:
:map! <F3> <C-R>=strftime('%c')<CR>

" The following command maps <F2> to insert the directory name of the current buffer:
:inoremap <F2> <C-R>=expand('%:p:h')<CR>

" change directory to the file being edited and  print the directory after changing
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" working directory is always the same as the file you are editing
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
nnoremap <leader>s :%s//gI<Left><Left><Left>

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=28

let g:highlightedyank_highlight_duration = 200

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Theming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


" A simple function for zooming in GUI version of Vim/Neovim
" Increases the font size with `amount`
function! Zoom(amount) abort
  call ZoomSet(matchstr(&guifont, '\d\+$') + a:amount)
endfunc

" Sets the font size to `font_size`
function ZoomSet(font_size) abort
  let &guifont = substitute(&guifont, '\d\+$', a:font_size, '')
endfunc

noremap <silent> <C-+> :call Zoom(v:count1)<CR>
noremap <silent> <C--> :call Zoom(-v:count1)<CR>
noremap <silent> <C-0> :call ZoomSet(11)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{
  \ 'path': '~/vimwiki',
  \ 'template_path': '~/vimwiki/templates',
  \ 'template_default': 'syntaxhl',
  \ 'template_ext': '.tpl'}]
