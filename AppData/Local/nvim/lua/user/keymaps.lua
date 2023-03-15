local function map(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Horizontal scroll
map({ "n", "i", "v" }, "<S-ScrollWheelUp>", "<ScrollWheelLeft>")
map({ "n", "i", "v" }, "<S-ScrollWheelDown>", "<ScrollWheelRight>")

-- distinguish between <Tab> and <C-i> (ctrl+i is mapped to <M-C-S-F6> in ahk,terminal)
map("n", "<M-C-S-F6>", "<C-i>")

-- de-tab
map("i", "<S-Tab>", "<C-d>")

-- change mapping for diagraphs
map("i", "<C-f>", "<C-k>")

-- Quit vim
map("n", "<M-F4>", ":qa!<CR>")

-- new line
map("i", "<C-CR>", "<C-o>o")

map("n", "gw", "*N")
map("x", "gw", [[y/\V<C-R>"<CR>N]])

--> Navigate buffers
-- NOTE: b# doesn't work with jumpoption=view
-- from: https://sharats.me/posts/automating-the-vim-workplace/#switching-to-alternate-buffer
-- My remapping of <C-^>. If there is no alternate file, and there's no count
-- given, then switch to next file. We use `bufloaded` to check for alternate
-- buffer presence. This will ignore deleted buffers, as intended. To get
-- default behaviour, use `bufexists` in it's place.
-- map("n", "<M-w>", ":<C-u>exe v:count ? v:count . 'b' : 'keepjumps b' . (bufloaded(0) ? '#' : 'n')<CR>")
-- map("i", "<M-w>", "<C-o>:keepjumps b#<CR>")
map({ "n", "i" }, "<M-w>", "<Cmd>keepjumps normal <CR>")
map("n", "<M-d>", function()
  -- switch back to previous buffer instead of going to next buffer
  local prevFile = vim.fn.expand("#")
  require("bufdelete").bufdelete(0)
  vim.cmd("keepjumps b " .. prevFile)
end, { desc = "delete buffer" })
map("n", "<M-c>", function()
  local prevFile = vim.fn.expand("#")
  require("bufdelete").bufwipeout(0)
  vim.cmd("keepjumps b " .. prevFile)
end, { desc = "wipeout buffer" })
-- map("n", "<M-D>", ":%bd <bar> e# <bar> bd#<CR>", { desc = "close all but current buffer" })
map("n", "<M-D>", ":BdeleteHidden<CR>", { desc = "delete hidden buffers" })
map("n", "<M-.>", ":bnext<CR>")
map("i", "<M-.>", "<Esc>:bnext<CR>")
map("n", "<M-,>", ":bprevious<CR>")
map("i", "<M-,>", "<Esc>:bprevious<CR>")
map("n", "<C-p>", "<Cmd>wincmd p<CR>")

-- Navigate tabs
-- Number + , to select a tab, i.e. type 1, to select the first tab.
for i = 1, 9 do
  map("n", i .. ",", i .. "gt")
end

-- Switch to last active tab
vim.cmd([[
  if !exists('g:Lasttab')
    let g:Lasttab = 1
    let g:Lasttab_backup = 1
  endif
  autocmd! TabLeave * let g:Lasttab_backup = g:Lasttab | let g:Lasttab = tabpagenr()
  autocmd! TabClosed * let g:Lasttab = g:Lasttab_backup
  nmap <silent> <C-h> :exe "tabn " . g:Lasttab<cr>
]])

-- Move text up and down(using nvim-gomove instead)
-- map("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- map("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- df to escape
-- map("i", "df", "<ESC>")

-- quick save
map("n", "<M-s>", ":silent update<CR>")
map("i", "<M-s>", "<Esc>:silent update<CR>")

-- Ctrl-Backspace to delete the previous word
map("i", "<C-BS>", "<C-w>", { noremap = false })
map("c", "<C-BS>", "<C-w>", { silent = false })

-- ctrl-z to undo
map("i", "<C-z>", "<C-o>:u<CR>")

-- undo break points
local undo_ch = { ",", ".", "!", "?", ";" }
for _, ch in ipairs(undo_ch) do
  map("i", ch, ch .. "<C-g>u")
end

-- Store relative line number jumps in the jumplist if they exceed a threshold.
map("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true })
map("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true })

-- When the :keepjumps command modifier is used, jumps are not stored in the jumplist.
map("n", "{", ":execute 'keepjumps norm! ' . v:count1 . '{'<CR>")
map("n", "}", ":execute 'keepjumps norm! ' . v:count1 . '}'<CR>")
map("n", "(", ":execute 'keepjumps norm! ' . v:count1 . '('<CR>")
map("n", ")", ":execute 'keepjumps norm! ' . v:count1 . ')'<CR>")

-- scroll with <C-j> <C-k>
-- from: https://vi.stackexchange.com/questions/10031/scroll-a-quarter-25-of-the-screen-up-or-down
vim.cmd([[
function! ScrollGolden(move)
  let height=winheight(0)
  if a:move == 'up'
    let prep='H'
    " let key="^Y"
    let key='gk'
    let post='zt'
  elseif a:move == 'down'
    let prep='L'
    " let key="^E"
    let key='gj'
    let post='zb'
  endif
  execute 'keepjumps normal! ' . prep . float2nr(round(height*0.12)) . key . post
endfunction
nnoremap <silent> <C-k> <cmd>call ScrollGolden('up')<CR>
vnoremap <silent> <C-k> <cmd>call ScrollGolden('up')<CR>
nnoremap <silent> <C-j> <cmd>call ScrollGolden('down')<CR>
vnoremap <silent> <C-j> <cmd>call ScrollGolden('down')<CR>
]])

-- center when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Faster scrolling
map("n", "<C-e>", "2<C-e>")
map("n", "<C-y>", "2<C-y>")

-- More comfortable jumping to marks
map("n", "'", "`")
map("n", "`", "'")

-- Split line with X
map("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>")

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z")

vim.cmd([[
  " line text object
  xnoremap il g_o^
  onoremap il :normal vil<CR>
  xnoremap al $o^
  onoremap al :normal val<CR>
  xnoremap ig GoggV
  onoremap ig :normal vig<CR>

  " better start and end of line
  nnoremap gh _
  xnoremap gh _
  onoremap gh :normal vgh<CR>
  nnoremap gl g_
  xnoremap gl g_
  onoremap gl :normal vgl<CR>
]])

-- use . to repeat a regular c-prefixed command as if it were perforced using cgn.
map("n", "g.", '/\\V<C-r>"<CR>cgn<C-a><Esc>', { silent = false })
-- search for the word under the cursor and perform cgn on it
map("n", "cg*", "*Ncgn", { silent = false })

-- Press * to search for the term under the cursor or a visual selection and
-- then press a key below to replace all instances of it in the current file.
map("n", "<leader>rr", ":%s///g<Left><Left>", { silent = false })
map("n", "<leader>rc", ":%s///gc<Left><left><Left>", { silent = false })

-- The same as above but instead of acting on the whole file it will be
-- restricted to the previously visually selected range.
map("x", "<leader>rr", ":s///g<Left><Left>", { silent = false })
map("x", "<leader>rc", ":s///gc<Left><left><Left>", { silent = false })

-- <leader>rw over word to find and replace all occurrences.
map("n", "<leader>ra", [[:%s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>]], { silent = false })

-- Replace selected characters, saving the word to which they belong(use dot to replace next occurrence)
map("x", "<leader>rw", [["sy:let @w='\<'.expand('<cword>').'\>' <bar> let @/=@s<CR>cgn]])

-- Replace full word
map("n", "<leader>rw", [[:let @/='\<'.expand('<cword>').'\>'<CR>cgn]])

-- Append to the end of a word
map("n", "<leader>sa", [[:let @/='\<'.expand('<cword>').'\>'<CR>cgn<C-r>"]])

-- from: https://old.reddit.com/r/neovim/comments/w59a4m/do_you_really_need_multiple_cursors_for_the/ih747rt/
-- Begin a "searchable" macro
map("x", "qi", [[y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>gvqi]])

-- Apply macro in the next instance of the search
map("n", "<F9>", "gn@i")

-- delete all trailing whitespace
map("n", "<F6>", [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]])

-- print current time
map({ "n", "i" }, "<F8>", function()
  local t = os.date("*t")
  local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
  print(time)
end)

-- Navigate quickfix list
map("n", "[q", ":cprevious<CR>")
map("n", "]q", ":cnext<CR>")

-- yank to system clipboard
map({ "n", "v" }, "<M-y>", '"+y')
map("n", "<M-Y>", '"+y$')
map({ "n", "v" }, "<M-p>", '"+p')
map("i", "<M-p>", "<C-r><C-o>+", { desc = "Inserts text literally, not as if you typed it" })
map("c", "<M-p>", "<C-r>+", { silent = false })
map({ "n", "v" }, "<M-S-p>", '"+P')

-- Copies last yank/cut to clipboard register
map("n", "<leader>cp", ':let @*=@"<CR>')

-- Redirect change/delete operations to the blackhole
map("n", "<leader>c", '"_c')
map("n", "<leader>C", '"_C')
map("n", "<leader>d", '"_d')
map("n", "<leader>D", '"_D')
-- -- x and X won't alter the register
-- map("n", "x", '"_x')
-- map("n", "X", '"_X')

-- unexpected behavior when pasting above highlighted text
map("v", "<leader>p", '"_dP')

-- change directory to the file being edited and print the directory after changing
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

-- Copy filename to clipboard
-- map("n", "<leader>cs", ":let @*=expand('%')<CR>:echo expand('%')<CR>")
map("n", "<leader>cs", ":echo expand('%')<CR>")
map("n", "<leader>cl", ":let @*=expand('%:p')<CR>:echo expand('%:p')<CR>")
-- nnoremap <silent> <leader>yf :call setreg(v:register, expand('%:p'))<CR>

-- paste from ditto
map("n", "<S-Insert>", '"+p')
map("v", "<S-Insert>", '"+p')
map("i", "<S-Insert>", "<C-r>+")

-- reselect pasted text
-- map("n", "sp", "`[v`]")

-- Quickly edit your macros(from vim-galore)
map("n", "<leader>me", ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- remove highlight
-- map("n", "<esc>", ":noh<cr>")

-- %% expands to the path of the directory that contains the current file.
-- works with with :cd, :grep etc.
vim.cmd("cabbr <expr> %% expand('%:h')")

-- type \e  to enter :e /some/path/ on the command line.
map("n", "<Bslash>e", ":e <C-R>=expand('%:h') . '\\'<CR>", { silent = false })

-- Use curl to upload visual selection to ix.io to easily share it: http://ix.io/3QMC
map("v", "<Bslash>c", [[:w !curl -F "f:1=<-" ix.io<CR>]])

-- Append ; at end of line
map("n", "<leader>;", [[:execute "normal! mqA;\<lt>esc>`q"<enter>]])

-- open window in new tab
map("n", "<leader>tn", "<C-w>T")

-- edit keymaps in new tab
-- map("n", "<leader>tk", ":tab drop $LOCALAPPDATA/nvim/lua/user/keymaps.lua<CR>:Tz nvim<CR>")
map("n", "<leader>tk", ":tab drop $LOCALAPPDATA/nvim/lua/user/keymaps.lua<CR>")

-- Quickly change font size in GUI
vim.cmd([[
command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
]])
map("n", "<M-=>", ":Bigger<CR>")
map("n", "<M-->", ":Smaller<CR>")
map("n", "<M-S-_>", ":set guifont=:h16<CR>")

-- Zoom / Restore window.
-- https://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
vim.cmd([[
function! ToggleZoom(toggle)
  if exists("t:restore_zoom") && (t:restore_zoom.win != winnr() || a:toggle == v:true)
    exec t:restore_zoom.cmd
    unlet t:restore_zoom
  elseif a:toggle
    let t:restore_zoom = { 'win': winnr(), 'cmd': winrestcmd() }
    vert resize | resize
  endi
endfunction

augroup restorezoom
  au WinEnter * silent! :call ToggleZoom(v:false)
augroup END
]])
map("n", "<C-q>", ":call ToggleZoom(v:true)<CR>")
map("t", "<C-q>", [[<C-\><C-n>:call ToggleZoom(v:true)<CR>i]])

-- search for regex pattern
-- map("n", "<M-l>", "<Cmd>call search('[([{<]')<CR>")

-- open current file in explorer
map("n", "<leader>fl", ":silent !start %:p:h<CR>")

-- Toggle quickfix window
map("n", "<leader>q", function()
  vim.cmd(not vim.g.quickfix_toggled and "cclose" or "copen")
  vim.g.quickfix_toggled = not vim.g.quickfix_toggled
end, { desc = "toggle quickfix window" })

-- toggle cmp(mapped <C-;> to <M-C-S-F7> in ahk,terminal)
map({ "i", "n" }, "<M-C-S-F7>", function()
  vim.g.cmp_active = not vim.g.cmp_active
end, { desc = "toggle cmp" })

----------------------------------
--- functions
----------------------------------

-- use black hole register when deleting empty line
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end

map("n", "dd", smart_dd, { expr = true })

-- Quickly add empty lines
vim.cmd([[
function! s:BlankUp() abort
  let cmd = 'put!=repeat(nr2char(10), v:count1)|silent '']+'
  if &modifiable
    let cmd .= '|silent! call repeat#set("\<Plug>(unimpaired-blank-up)", v:count1)'
  endif
  return cmd
endfunction

function! s:BlankDown() abort
  let cmd = 'put =repeat(nr2char(10), v:count1)|silent ''[-'
  if &modifiable
    let cmd .= '|silent! call repeat#set("\<Plug>(unimpaired-blank-down)", v:count1)'
  endif
  return cmd
endfunction

nnoremap <silent> <Plug>(unimpaired-blank-up)   :<C-U>exe <SID>BlankUp()<CR>
nnoremap <silent> <Plug>(unimpaired-blank-down) :<C-U>exe <SID>BlankDown()<CR>
]])

map("n", "[<space>", "<Plug>(unimpaired-blank-up)")
map("n", "]<space>", "<Plug>(unimpaired-blank-down)")

-- autoload/functions.vim
map("v", "<leader>cy", ":call functions#CompleteYank()<CR>")
map("x", "@", ":<C-u>call functions#ExecuteMacroOverVisualRange()<CR>")
map("n", "<leader>hl", ":call functions#GetHighlightGroupUnderCursor()<CR>")
-- map("n", "gx", ":call functions#open_url_under_cursor()<CR>")

-- essentials.lua functions
-- map("n", "<F2>", ":lua require('user.essentials').rename()<CR>")
map("n", "gx", ":lua require('user.essentials').open_in_browser()<CR>")
map("n", "g/", ":lua require('user.essentials').toggle_comment()<CR>")
map("v", "g/", ":lua require('user.essentials').toggle_comment(true)<CR>")
map("n", "<leader>ru", ":lua require('user.essentials').run_file()<CR>")
map("n", "<leader>sb", ":lua require('user.essentials').swap_bool()<CR>")
map("n", "<leader>sc", ":lua require('user.essentials').scratch()<CR>", { desc = "Command to scratch buffer" })

----------------------------------
--- definition of new commands ---
----------------------------------

vim.cmd([[
command! JsonFormat :%!jq .
command! JsonUnformat :%!jq -c .
command! TabToSpace silent! call functions#T2S()
command! SpaceToTab silent! call functions#S2T()
command! ReplaceFile silent! call functions#ReplaceFile()
command! RenameFile call functions#RenameFile()
command! RemoveFile call functions#RemoveFile()
command! DeleteHiddenBuffers call functions#DeleteHiddenBuffers()
command! -nargs=1 -complete=command -bar -range Redir silent call functions#Redir(<q-args>, <range>, <line1>, <line2>)
]])

vim.api.nvim_create_user_command("Json", function()
  vim.cmd([[ enew | norm! "+p ]])
  vim.cmd([[ setlocal filetype=json noswapfile ]])
  vim.cmd([[ nnoremap <silent> <buffer> q :bw!<CR> ]])
end, { force = true, desc = "paste JSON in new buffer" })

vim.api.nvim_create_user_command("Mdn", function(cmd_opts)
  local url = "https://mdn.io/"
  vim.cmd(":silent !start " .. url .. unpack(cmd_opts.fargs))
end, { nargs = 1, desc = "search in mdn" })

vim.api.nvim_create_user_command("Bonly", function()
  vim.cmd("silent! execute '%bd|e#|bd#'")
end, { desc = "delete all but current buffer" })

vim.api.nvim_create_user_command("BdeleteHidden", function()
  local hidden_bufs = vim.tbl_filter(function(bufnr)
    return vim.fn.getbufinfo(bufnr)[1].hidden == 1
  end, vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(hidden_bufs) do
    require("bufdelete").bufdelete(bufnr)
  end
end, { bang = true, desc = "delete hidden buffers" })

----------------------------------
---------- abbreviations ---------
----------------------------------

vim.cmd([[
iab <expr> t/ strftime('%Y-%m-%d')
iab <expr> td/ strftime('TODO(' . '%Y-%m-%d):')
" Open help and man pages in a tab:
cab he tab help
cab mdn Mdn
]])

-----------------------------------
------------- Plugins -------------
-----------------------------------

---------------------------------------------------------------
-- => telescope.nvim
---------------------------------------------------------------
-- map(
--   "n",
--   "<leader>f",
--   "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
-- )
map("n", "<leader>fd", function()
  require("telescope.builtin").find_files({ cwd = "~/.config/symlinks", prompt_title = "Dotfiles" })
end)
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h"), prompt_title = "From Current Buffer" })
end)
map("n", "<leader>fw", function()
  require("telescope").extensions.recent_files.pick({ initial_mode = "normal" })
end)
map("n", "<leader>fn", function()
  require("telescope").extensions.neoclip.default(require("telescope.themes").get_dropdown({
    initial_mode = "normal",
    layout_strategy = "vertical",
    layout_config = { height = 0.95 },
  }))
end)
map("n", "<leader>fi", function()
  require("telescope").extensions.tailiscope.base(require("telescope.themes").get_dropdown({
    initial_mode = "normal",
    layout_strategy = "vertical",
    layout_config = { height = 0.95 },
    preview = {
      hide_on_startup = false, -- hide previewer when picker starts
    },
  }))
end)
map("n", "<leader>fm", function()
  require("telescope").extensions.macroscope.default({ initial_mode = "normal" })
end)
map("n", "<leader>b", ":Telescope buffers<CR>")
map("n", "<leader>fe", ":Telescope resume<CR>")
map("n", "<leader>fs", ":Telescope find_files<CR>")
map("n", "<leader>fr", ":Telescope registers<CR>")
map("n", "<leader>fo", ":Telescope oldfiles<CR>")
map("n", "<leader>fv", ":Telescope vim_options<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fk", ":Telescope keymaps<CR>")
map("n", "<leader>f;", ":Telescope command_history<CR>")
map("n", "<leader>f/", ":Telescope search_history<CR>")
map("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>")
map("n", "<leader>fp", ":Telescope workspaces<CR>")
map("n", "<leader>lr", ":Telescope lsp_references<CR>")
map("n", "<leader>ld", ":Telescope diagnostics<CR>")
map("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>")
map("n", "<leader>lt", ":Telescope treesitter<CR>")

---------------------------------------------------------------
-- => gomove.nvim
---------------------------------------------------------------
map("n", "<M-Left>", "<Plug>GoNSMLeft", { noremap = false })
map("n", "<M-Down>", "<Plug>GoNSMDown", { noremap = false })
map("n", "<M-Up>", "<Plug>GoNSMUp", { noremap = false })
map("n", "<M-Right>", "<Plug>GoNSMRight", { noremap = false })

map("x", "<M-Left>", "<Plug>GoVSMLeft", { noremap = false })
map("x", "<M-Down>", "<Plug>GoVSMDown", { noremap = false })
map("x", "<M-Up>", "<Plug>GoVSMUp", { noremap = false })
map("x", "<M-Right>", "<Plug>GoVSMRight", { noremap = false })

map("n", "<M-S-Left>", "<Plug>GoNSDLeft", { noremap = false })
map("n", "<M-S-Down>", "<Plug>GoNSDDown", { noremap = false })
map("n", "<M-S-Up>", "<Plug>GoNSDUp", { noremap = false })
map("n", "<M-S-Right>", "<Plug>GoNSDRight", { noremap = false })

map("x", "<M-S-Left>", "<Plug>GoVSDLeft", { noremap = false })
map("x", "<M-S-Down>", "<Plug>GoVSDDown", { noremap = false })
map("x", "<M-S-Up>", "<Plug>GoVSDUp", { noremap = false })
map("x", "<M-S-Right>", "<Plug>GoVSDRight", { noremap = false })

--------------------------------------------------------------
-- => sessions.nvim
---------------------------------------------------------------
map("n", "<leader>sl", ":SessionsLoad<CR>")
map("n", "<leader>ss", ":SessionsSave<CR>")
map("n", "<leader>sd", ":SessionsStop<CR>")

---------------------------------------------------------------
-- => vim-illuminate
---------------------------------------------------------------
map({ "n", "v" }, "<M-n>", '<cmd>lua require"illuminate".goto_next_reference()<CR>')
map({ "n", "v" }, "<M-S-n>", '<cmd>lua require"illuminate".goto_prev_reference()<CR>')

---------------------------------------------------------------
-- => nvim-colorizer.lua, document-color.nvim
---------------------------------------------------------------
map("n", "<leader>tt", "<cmd>ColorizerToggle<CR>")
map("n", "<leader>tw", "<cmd>lua require('document-color').buf_toggle()<CR>")

---------------------------------------------------------------
-- => hop.nvim
---------------------------------------------------------------
-- map("", "sf", "<cmd>HopChar2<CR>")
-- map("", "sg", "<cmd>HopChar1<CR>")
-- map("", "sj", "<cmd>HopLineStartAC<CR>")
-- map("", "sk", "<cmd>HopLineStartBC<CR>")
-- map("", "s/", "<cmd>HopPattern<CR>")

---------------------------------------------------------------
-- => pounce.nvim
---------------------------------------------------------------
map({ "n", "x" }, "s", "<cmd>Pounce<CR>")
map({ "n", "x" }, "S", "<cmd>PounceRepeat<CR>")
map("o", "gs", "<cmd>Pounce<CR>") -- s is used by nvim-surround

---------------------------------------------------------------
-- => bufferline.nvim
---------------------------------------------------------------
-- map("n", "]b", ":BufferLineCycleNext<CR>")
-- map("n", "[b", ":BufferLineCyclePrev<CR>")
-- map("n", "<M-.>", ":BufferLineCycleNext<CR>")
-- map("i", "<M-.>", "<Esc>:BufferLineCycleNext<CR>")
-- map("n", "<M-,>", ":BufferLineCyclePrev<CR>")
-- map("i", "<M-,>", "<Esc>:BufferLineCyclePrev<CR>")
-- map("n", "<A-S->>", ":BufferLineMoveNext<CR>")
-- map("n", "<A-S-<>", ":BufferLineMovePrev<CR>")
-- map("n", "Q", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>")

---------------------------------------------------------------
-- => ton/vim-bufsurf
---------------------------------------------------------------
-- map("n", "<C-j>", "<Plug>(buf-surf-forward)")
-- map("n", "<C-k>", "<Plug>(buf-surf-back)")
