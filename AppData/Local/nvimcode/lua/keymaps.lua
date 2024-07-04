local function map(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

if vim.g.vscode then
  -- undo/REDO via vscode
  map('n', 'u', "<Cmd>call VSCodeNotify('undo')<CR>")
  map('n', '<C-r>', "<Cmd>call VSCodeNotify('redo')<CR>")
end

-- Horizontal scroll
map({ 'n', 'i', 'v' }, '<S-ScrollWheelUp>', '<ScrollWheelLeft>')
map({ 'n', 'i', 'v' }, '<S-ScrollWheelDown>', '<ScrollWheelRight>')

-- distinguish between <Tab> and <C-i> (ctrl+i is mapped to <M-C-S-F6> in ahk,terminal)
map('n', '<M-C-S-F6>', '<C-i>')

-- de-tab
map('i', '<S-Tab>', '<C-d>')

-- change mapping for diagraphs
map('i', '<C-f>', '<C-k>')

-- Quit vim
map('n', '<M-F4>', ':qa!<CR>')

-- new line
map('i', '<C-CR>', '<C-o>o')

-- remove highlight
map('n', '<Esc>', '<Cmd>noh | stopinsert<CR>', { desc = 'Escape and clear hlsearch/messages' })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  'n',
  '<C-c>',
  '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
  { desc = 'Redraw / clear hlsearch / diff update' }
)

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- search for word under cursor without moving
map('n', 'gw', '*N')
map('x', 'gw', [[y/\V<C-R>"<CR>N]])

-- -- Move Lines
-- map('n', '<M-Down>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
-- map('n', '<M-Up>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
-- map('i', '<M-Down>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
-- map('i', '<M-Up>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
-- map('v', '<M-Down>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
-- map('v', '<M-Up>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Navigate tabs
-- Number + , to select a tab, i.e. type 1, to select the first tab.
for i = 1, 9 do
  map('n', i .. ',', i .. 'gt')
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
map({ 'n', 'x' }, '<M-s>', '<Cmd>silent update<CR>')
map('i', '<M-s>', '<Esc>:silent update<CR>')

-- Ctrl-Backspace to delete the previous word
map('i', '<C-BS>', '<C-w>', { noremap = false })
map('c', '<C-BS>', '<C-w>', { silent = false })

map('i', '<C-Del>', '<C-o>dw')

-- ctrl-z to undo
map('i', '<C-z>', '<C-o>:u<CR>')

-- undo break points
local undo_ch = { ',', '!', '?', ';' }
for _, ch in ipairs(undo_ch) do
  map('i', ch, ch .. '<C-g>u')
end

-- Store relative line number jumps in the jumplist if they exceed a threshold.
-- map('n', 'k', '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true })
-- map('n', 'j', '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true })

-- When the :keepjumps command modifier is used, jumps are not stored in the jumplist.
map('n', '{', ":execute 'keepjumps norm! ' . v:count1 . '{'<CR>")
map('n', '}', ":execute 'keepjumps norm! ' . v:count1 . '}'<CR>")
map('n', '(', ":execute 'keepjumps norm! ' . v:count1 . '('<CR>")
map('n', ')', ":execute 'keepjumps norm! ' . v:count1 . ')'<CR>")

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
    let prep='Lgj'
    " let key="^E"
    let key='gj'
    let post='zb'
  endif
  execute 'keepjumps normal! ' . prep . float2nr(round(height*0.14)) . key . post
endfunction
nnoremap <silent> <C-k> <cmd>call ScrollGolden('up')<CR>
vnoremap <silent> <C-k> <cmd>call ScrollGolden('up')<CR>
nnoremap <silent> <C-j> <cmd>call ScrollGolden('down')<CR>
vnoremap <silent> <C-j> <cmd>call ScrollGolden('down')<CR>
]])

-- -- center when scrolling
-- map('n', '<C-d>', '<C-d>zz')
-- map('n', '<C-u>', '<C-u>zz')
map('n', 'H', 'H')
map('n', 'L', 'Lgj')

-- Faster scrolling
map('n', '<C-e>', '2<C-e>')
map('n', '<C-y>', '2<C-y>')


-- More comfortable jumping to marks
map('n', "'", '`')
map('n', '`', "'")

-- like `gi` but stay in normal mode
map('n', 'mi', '`^')

-- Split line with X
map('n', 'X', ':keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>')

-- Keep the cursor in place while joining lines
-- map('n', 'J', 'mzJ`z')

vim.cmd([[
  " line text object
  xnoremap il g_o^
  onoremap <silent> il :normal vil<CR>
  xnoremap al $o^
  onoremap <silent> al :normal val<CR>
  xnoremap ig GoggV
  onoremap <silent> ig :normal vig<CR>

  " better start and end of line
  nnoremap gh _
  xnoremap gh _
  onoremap <silent> gh :normal vgh<CR>
  nnoremap gl g_
  xnoremap gl g_
  onoremap <silent> gl :normal vgl<CR>
]])

-- limit the search in the visual selection
map('x', '<leader>/', '<Esc>/\\%V', { desc = 'limit the search in the visual selection', silent = false })

-- use . to repeat a regular c-prefixed command as if it were perforced using cgn.
map('n', 'g.', '/\\V<C-r>"<CR>cgn<C-a><Esc>', { silent = false })
-- search for the word under the cursor and perform cgn on it
map('n', 'cg*', '*Ncgn', { silent = false })

-- Press * to search for the term under the cursor or a visual selection and
-- then press a key below to replace all instances of it in the current file.
map('n', '<leader>rr', ':%s///g<Left><Left>', { silent = false })
map('n', '<leader>rc', ':%s///gc<Left><left><Left>', { silent = false })

-- The same as above but instead of acting on the whole file it will be
-- restricted to the previously visually selected range.
map('x', '<leader>rr', ':s///g<Left><Left>', { silent = false })
map('x', '<leader>rc', ':s///gc<Left><left><Left>', { silent = false })

-- <leader>ra over word to find and replace all occurrences.
map('n', '<leader>ra', [[:%s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>]], { silent = false })

-- Replace selected characters, saving the word to which they belong(use dot to replace next occurrence)
map('x', '<leader>rw', [["sy:let @w='\<'.expand('<cword>').'\>' <bar> let @/=@s<CR>cgn]])

-- Replace full word
map('n', '<leader>rw', [[:let @/='\<'.expand('<cword>').'\>'<CR>cgn]])

-- Append to the end of a word
map('n', '<leader>sa', [[:let @/='\<'.expand('<cword>').'\>'<CR>cgn<C-r>"]])

-- Search selection and apply macro
-- from: https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/
map('x', 'qi', [[y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>gvqi]])

-- Apply macro in the next instance of the search
map('n', '<F9>', 'gn@i')

-- delete all trailing whitespace
map('n', '<F6>', [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]])

-- print current time
map({ 'n', 'i' }, '<F8>', function()
  local t = os.date('*t')
  local time = string.format('%02d:%02d:%02d', t.hour, t.min, t.sec)
  print(time)
end)

-- Navigate quickfix list
map('n', '[q', ':cprevious<CR>')
map('n', ']q', ':cnext<CR>')

-- yank to system clipboard
-- map({ 'n', 'v' }, '<M-y>', '"+y')
-- map('n', '<M-Y>', '"+y$')
-- map({ 'n', 'v' }, '<M-p>', '"+p')
-- map('i', '<M-p>', '<C-r><C-o>+', { desc = "Insert the contents of a register literally and don't auto-indent" })
-- map('c', '<M-p>', '<C-r>+', { silent = false })
-- map({ 'n', 'v' }, '<M-S-p>', '"+P')
-- NOTE: <M-y> and <M-p> not working in vscode
map({ 'n', 'v' }, '<leader>y', '"+y')
map('n', '<leader>Y', '"+y$')
map({ 'n', 'v' }, '<leader>p', '"+p')

-- paste from ditto
map('n', '<S-Insert>', '"+p')
map('v', '<S-Insert>', '"+p')
map('i', '<S-Insert>', '<C-r>+')

-- reselect pasted or yanked text
map('n', 'gy', '`[v`]', { desc = 'reselect pasted or yanked text' })

-- Copies last yank/cut to clipboard register
map('n', '<leader>cy', ':let @*=@"<CR>', { desc = 'Copy last yank/cut to clipboard' })
map('n', '<leader>dy', ':let @*=@"<CR>', { desc = 'Copy last yank/cut to clipboard' })

-- Redirect change/delete operations to the blackhole
-- NOTE: before these mapping map something with <leader>c and <leader>d like
-- above to prevent it from triggering instantly(fix for mini.clue)
map({ 'n', 'x' }, '<leader>c', '"_c')
map('n', '<leader>C', '"_C')
map({ 'n', 'x' }, '<leader>d', '"_d')
map('n', '<leader>D', '"_D')
-- -- x and X won't alter the register
-- map("n", "x", '"_x')
-- map("n", "X", '"_X')

-- unexpected behavior when pasting above highlighted text
-- map('v', '<leader>p', '"_dP')

-- change directory to the file being edited and print the directory after changing
map('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = 'change directory to the file being edited' })

-- Copy absolute file name to clipboard
map(
  'n',
  '<leader>cl',
  [[:let @*=expand('%:p')<CR>:echo expand('%:p') .. "\ncopied to clipboard\n"<CR>]],
  { desc = 'Copy absolute file name to clipboard' }
)
-- nnoremap <silent> <leader>yf :call setreg(v:register, expand('%:p'))<CR>

-- Quickly edit your macros(from vim-galore)
-- Use it like this <leader>m or "q<leader>m.
map(
  'n',
  '<leader>m',
  ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
  { desc = 'Quickly edit macros' }
)

-- %% expands to the path of the directory that contains the current file.
-- works with with :cd, :grep etc.
vim.cmd("cabbr <expr> %% expand('%:h')")

-- type \e  to enter :e /some/path/ on the command line.
map('n', '<Bslash>e', ":e <C-R>=expand('%:h') . '\\'<CR>", { silent = false })

-- Use curl to upload visual selection to ix.io to easily share it: http://ix.io/3QMC
map('v', '<Bslash>c', [[:w !curl -F "f:1=<-" ix.io<CR>]])

-- Append ; at end of line
-- map('n', '<leader>;', [[:execute "normal! mqA;\<lt>esc>`q"<enter>]])

-- open window in new tab
map('n', '<leader>tn', '<C-w>T')

-- edit keymaps in new tab
-- map("n", "<leader>tk", ":tab drop $LOCALAPPDATA/nvim/lua/user/keymaps.lua<CR>:Tz nvim<CR>")
map('n', '<leader>tk', ':tab drop $LOCALAPPDATA/nvim/lua/user/keymaps.lua<CR>')

-- open current file in explorer
map('n', '<leader>ue', ':silent !start %:p:h<CR>', { desc = 'open current file in explorer' })

-- Toggle quickfix window
map('n', '<leader>x', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end

  if qf_exists == true then
    vim.cmd('cclose')
    return
  end
  -- dont open if quickfix is empty
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd('copen')
  end
end, { desc = 'toggle quickfix window' })

-- Terminal Mappings
map('t', '`', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
map('t', '<C-r>', [['<C-\><C-n>"' . nr2char(getchar()) . 'pi']], { expr = true })
map('t', '<M-p>', [[<C-\><C-n>"+pi]])

----------------------------------
--- functions
----------------------------------

-- use black hole register when deleting empty line
local function smart_dd()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end

map('n', 'dd', smart_dd, { expr = true })

-- Quickly add empty lines
map('n', '[<space>', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = 'Put empty line above' })
map('n', ']<space>', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = 'Put empty line below' })

-- autoload/functions.vim
map('v', '<leader>cy', ':call functions#CompleteYank()<CR>')
map('x', '@', ':<C-u>call functions#ExecuteMacroOverVisualRange()|stopinsert<CR>')

-- essentials.lua functions
map('n', '<leader>ru', ":lua require('essentials').run_file()<CR>")
map('n', '<leader>sb', ":lua require('essentials').swap_bool()<CR>")
map('n', '<leader>sc', ":lua require('essentials').scratch()<CR>", { desc = 'Command to scratch buffer' })

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

vim.api.nvim_create_user_command('Json', function()
  vim.cmd([[ enew | norm! "+p ]])
  vim.cmd([[ setlocal filetype=json noswapfile ]])
  vim.cmd([[ nnoremap <silent> <buffer> q :bw!<CR> ]])
end, { force = true, desc = 'paste JSON in new buffer' })

vim.api.nvim_create_user_command('Mdn', function(cmd_opts)
  local url = 'https://mdn.io/'
  vim.cmd('silent !start "" "' .. url .. unpack(cmd_opts.fargs) .. '"')
end, { nargs = 1, desc = 'search in mdn' })

vim.api.nvim_create_user_command('Bonly', function()
  vim.cmd("silent! execute '%bd|e#|bd#'")
end, { desc = 'delete all but current buffer' })

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

local fn = vim.fn
local api = vim.api

-- move around indents
-- from https://github.com/tj-moody/.dotfiles/blob/c2afec06b68cd0413c20d332672907c11f0a9c47/nvim/lua/mappings.lua#L171C1-L171C1
-- Adapted from https://vi.stackexchange.com/a/12870
-- Traverse to indent >= or > current indent
---@param direction integer 1 - forwards | -1 - backwards
---@param equal boolean include lines equal to current indent in search?
local function indent_traverse(direction, equal) -- {{{
  return function()
    -- Get the current cursor position
    local current_line, column = unpack(api.nvim_win_get_cursor(0))
    local match_line = current_line
    local match_indent = false
    local match = false
    local buf_length = api.nvim_buf_line_count(0)

    -- Look for a line of appropriate indent
    -- level without going out of the buffer
    while (not match) and (match_line ~= buf_length) and (match_line ~= 1) do
      match_line = match_line + direction
      local match_line_str = api.nvim_buf_get_lines(0, match_line - 1, match_line, false)[1]
      -- local match_line_is_whitespace = match_line_str and match_line_str:match('^%s*$')
      local match_line_is_whitespace = match_line_str:match('^%s*$')

      if equal then
        match_indent = fn.indent(match_line) <= fn.indent(current_line)
      else
        match_indent = fn.indent(match_line) < fn.indent(current_line)
      end
      match = match_indent and not match_line_is_whitespace
    end

    -- If a line is found go to line
    if match or match_line == buf_length then
      vim.cmd('normal! m`') -- add current position to jumplist with m`
      fn.cursor({ match_line, column + 1 })
    end
  end
end

map({ 'n', 'x' }, 'gj', indent_traverse(1, true)) -- next equal indent
map({ 'n', 'x' }, 'gk', indent_traverse(-1, true)) -- previous equal indent
map({ 'n', 'x' }, 'gJ', indent_traverse(1, false)) -- next bigger indent
map({ 'n', 'x' }, 'gK', indent_traverse(-1, false)) -- previous bigger indent

-- toggle options
local toggle = require('utils.toggle')
-- stylua: ignore start
map('n', '<leader>us', function() toggle('spell') end, { desc = 'Toggle Spelling' })
map('n', '<leader>uw', function() toggle('wrap') end, { desc = 'Toggle Word Wrap' })
map('n', '<leader>un', function() toggle('number') end, { desc = 'Toggle Number' })
map('n', '<leader>ul', function() toggle('relativenumber') end, { desc = 'Toggle Relative Line Numbers' })
map('n', '<leader>uL', function() toggle.number() end, { desc = 'Toggle Line Numbers' })
map('n', '<leader>ud', function() toggle.diagnostics() end, { desc = 'Toggle Diagnostics' })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map('n', '<leader>uc', function() toggle('conceallevel', false, { 0, conceallevel }) end, { desc = 'Toggle Conceal' })

if vim.lsp.inlay_hint then
  map('n', '<leader>uh', function() vim.lsp.inlay_hint(0, nil) end, { desc = 'Toggle Inlay Hints' })
end

map('n', '<leader>ut', function()
  if vim.b.ts_highlight then vim.treesitter.stop()
  else vim.treesitter.start() vim.opt.emoji = true end
end, { desc = 'Toggle Treesitter Highlight' })
-- stylua: ignore end

map('n', '<leader>la', '<Cmd>Lazy<CR>', { desc = 'Lazy' })
map('n', '<leader>uf', vim.show_pos, { desc = 'Inspect Pos' })
-- print current/alternate file name
map(
  'n',
  '<leader>up',
  [[:echo "current file: " .. expand('%') .. "\nalternate file: " ..expand('#')<CR>]],
  { desc = 'Print current file/alternate name' }
)
