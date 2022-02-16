local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Quit vim
keymap("n", "<M-F4>", ":qa!<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("i", "<M-w>", "<esc><C-^>", opts)
keymap("n", "<M-w>", "<C-^>", opts)
keymap("n", "<M-d>", ":BDelete this<CR>", opts)
keymap("n", "]b", ":bnext", opts)
keymap("n", "[b", ":bprevious<CR>", opts)
keymap("n", "<M-.>", ":bnext<CR>", opts)
keymap("i", "<M-.>", "<Esc>:bnext<CR>", opts)
keymap("n", "<M-,>", ":bprevious<CR>", opts)
keymap("i", "<M-,>", "<Esc>:bprevious<CR>", opts)
keymap("n", "Q", ":BDelete hidden<CR>", opts)

-- Move text up and down(using nvim-gomove instead)
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- df to escape
-- keymap("i", "df", "<ESC>", opts)

-- quick save
keymap("n", "<M-s>", ":w<CR>", opts)
keymap("i", "<M-s>", "<Esc>:w<CR>", opts)

-- Ctrl-Backspace to delete the previous word
keymap("i", "<C-BS>", "<C-W>", opts)
keymap("c", "<C-BS>", "<C-W>", {})

-- ctrl-z to undo
keymap("i", "<C-z>", "<C-o>:u<CR>", opts)

-- undo break points
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", "!", "!<c-g>u", opts)
keymap("i", "?", "?<c-g>u", opts)

-- jumplit mutations
vim.cmd([[
 nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
 nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
]])

-- Keep the cursor in place while joining lines
keymap("n", "J", "mzJ`z", opts)

vim.cmd([[
  " line text object
  xnoremap il g_o^
  onoremap il :normal vil<CR>
  xnoremap al $o^
  onoremap al :normal val<CR>
  xnoremap i% GoggV
  onoremap i% :normal vi%<CR>

  " better start and end of line
  nnoremap gh _
  xnoremap gh _
  onoremap gh :normal vgh<CR>
  nnoremap gl g_
  xnoremap gl g_
  onoremap gl :normal vgl<CR>
]])

-- search for visually selected text
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], {})

-- use . to repeat a regular c-prefixed command as if it were perforced using cgn.
keymap("n", "g.", '/\\V<C-r>"<CR>cgn<C-a><Esc>', {})
-- search for the word under the cursor and perform cgn on it
keymap("n", "cg*", "*Ncgn", {})

-- Press * to search for the term under the cursor or a visual selection and
-- then press a key below to replace all instances of it in the current file.
keymap("n", "<leader>r", ":%s///g<Left><Left>", {})
keymap("n", "<leader>rc", ":%s///gc<Left><left><Left>", {})

-- The same as above but instead of acting on the whole file it will be
-- restricted to the previously visually selected range.
keymap("x", "<leader>r", ":s///g<Left><Left>", {})
keymap("x", "<leader>rc", ":s///gc<Left><left><Left>", {})

-- Toggle spell check.
keymap("n", "<F5>", ":setlocal spell!<CR>", opts)

-- delete all trailing whitespace
keymap("n", "<F6>", [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]], opts)

-- Toggle visually showing all whitespace characters.
keymap("n", "<F7>", ":set list!<CR>", opts)
keymap("i", "<F7>", "<C-o>:set list!<CR>", opts)

-- Toggle relative line numbers and regular line numbers.
keymap("n", "<F8>", ":set invrelativenumber<CR>", opts)

-- Navigate quickfix list
keymap("n", "[q", ":cprevious<CR>", opts)
keymap("n", "]q", ":cnext<CR>", opts)

-- yank to system clipboard
keymap("n", "<M-y>", '"+y', opts)
keymap("v", "<M-y>", '"+y', opts)
keymap("n", "<M-p>", '"+p', opts)
keymap("v", "<M-p>", '"+p', opts)
keymap("i", "<M-p>", "<C-r>+", opts)
keymap("c", "<M-p>", "<C-r>+", {})
keymap("n", "<M-S-p>", '"+P', opts)
keymap("v", "<M-S-p>", '"+P', opts)

-- Copies last yank/cut to clipboard register
keymap("n", "<leader>cp", ':let @*=@"<CR>', opts)

-- Redirect change/delete operations to the blackhole
keymap("n", "<leader>c", '"_c', opts)
keymap("n", "<leader>C", '"_C', opts)
keymap("n", "<leader>d", '"_d', opts)
keymap("n", "<leader>D", '"_D', opts)
-- -- x and X won't alter the register
-- keymap("n", "x", '"_x', opts)
-- keymap("n", "X", '"_X', opts)

-- change directory to the file being edited and print the directory after changing
keymap("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", opts)

-- Copy filename to clipboard
keymap("n", "<leader>cs", ":let @*=expand('%')<CR>:echo expand('%')<CR>", opts)
keymap("n", "<leader>cl", ":let @*=expand('%:p')<CR>:echo expand('%:p')<CR>", opts)
-- nnoremap <silent> <leader>yf :call setreg(v:register, expand('%:p'))<CR>

-- paste from ditto
keymap("n", "<S-Insert>", '"+p', opts)
keymap("v", "<S-Insert>", '"+p', opts)
keymap("i", "<S-Insert>", "<C-r>+", opts)

-- reselect pasted text
keymap("n", "sp", "`[v`]", opts)

-- visual-at from: You don’t need more than one cursor in vim
-- https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.mrcxaaybf
vim.cmd([[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])

-- Quickly edit your macros(from vim-galore)
keymap("n", "<leader>m", ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- unexpected behavior when pasting above highlighted text(broken mapping)
-- keymap("v", "p", '"_dP', opts)

-- format
keymap("n", "<M-S-f>", ":Format<cr>", opts)

-- remove highlight
keymap("n", "<esc>", ":noh<cr>", opts)

-- Quickly add empty lines
-- keymap("n", "[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", opts)
-- keymap("n", "]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>", opts)
keymap("n", "[<space>", "O<Esc>", {})
keymap("n", "]<space>", "o<Esc>", {})

-- faster horizontal navigation
keymap("n", "zl", "10zl", opts)
keymap("n", "zh", "10zh", opts)

-- rename current file
vim.cmd([[
function! s:RenameFile()
  let old_name = expand('%')
  let new_name = input('Rename: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    call delete(expand('#:p')) | bd # | redraw!
  endif
endfunction
" map <leader>n :call RenameFile()<cr>
command! Rename call <SID>RenameFile()
]])

-- remove current file
vim.cmd([[
function! s:RemoveFile()
  let choice = confirm("Remove file?", "&Yes!\n&No", 1)
  if choice == 1
    call delete(expand('%:p')) | bdelete!
  endif
endfunction
command! Remove call <SID>RemoveFile()
]])

-- Redirect the output of a Vim or external command into a scratch buffer
-- source: https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
vim.cmd([[
function! Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let cmd = a:cmd =~' %'
      \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
      \ : matchstr(a:cmd, '^!\zs.*')
    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . " <<< $" . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif
  vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
]])

--  %% expands to the path of the directory that contains the current file.
-- works with with :cd, :grep etc.
vim.cmd("cabbr <expr> %% expand('%:h')")

-- type \e  to enter :e /some/path/ on the command line.
keymap("n", "<Bslash>e", ":e <C-R>=expand('%:h') . '/'<CR>", {})

--------------------------- Plugins ---------------------------
---------------------------------------------------------------
-- => telescope.nvim
---------------------------------------------------------------
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- keymap(
--   "n",
--   "<leader>f",
--   "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
--   opts
-- )
keymap(
  "n",
  "<leader>fd",
  "<cmd>lua require'telescope.builtin'.find_files({ cwd='~/.config/symlinks', prompt_title='dotfiles' })<cr>",
  opts
)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fr", ":Telescope resume<CR>", opts)
keymap("n", "<leader>b", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "q/", ":Telescope search_history<CR>", opts)
keymap("n", "q:", ":Telescope command_history<CR>", opts)
keymap("n", "<leader>p", ":Telescope workspaces<CR>", opts)
keymap("n", "<leader>fn", ":Telescope neoclip<CR>", opts)
keymap("n", "<leader>lr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>ld", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>lt", ":Telescope treesitter<CR>", opts)

---------------------------------------------------------------
-- => lir.nvim, nvim-tree.nvim
---------------------------------------------------------------
-- keymap("n", "<leader>e", ":lua require'lir.float'.toggle()<CR>", opts)
keymap("n", "<M-e>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", opts)

---------------------------------------------------------------
-- => gomove.nvim
---------------------------------------------------------------
keymap("n", "<M-Left>", "<Plug>GoNSMLeft", {})
keymap("n", "<M-Down>", "<Plug>GoNSMDown", {})
keymap("n", "<M-Up>", "<Plug>GoNSMUp", {})
keymap("n", "<M-Right>", "<Plug>GoNSMRight", {})

keymap("x", "<M-Left>", "<Plug>GoVSMLeft", {})
keymap("x", "<M-Down>", "<Plug>GoVSMDown", {})
keymap("x", "<M-Up>", "<Plug>GoVSMUp", {})
keymap("x", "<M-Right>", "<Plug>GoVSMRight", {})

keymap("n", "<M-S-Left>", "<Plug>GoNSDLeft", {})
keymap("n", "<M-S-Down>", "<Plug>GoNSDDown", {})
keymap("n", "<M-S-Up>", "<Plug>GoNSDUp", {})
keymap("n", "<M-S-Right>", "<Plug>GoNSDRight", {})

keymap("x", "<M-S-Left>", "<Plug>GoVSDLeft", {})
keymap("x", "<M-S-Down>", "<Plug>GoVSDDown", {})
keymap("x", "<M-S-Up>", "<Plug>GoVSDUp", {})
keymap("x", "<M-S-Right>", "<Plug>GoVSDRight", {})

---------------------------------------------------------------
-- => harpoon.nvim
---------------------------------------------------------------
keymap("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<M-f>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
-- keymap("n", "<leader>hc", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)
keymap("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>", opts)

--------------------------------------------------------------
-- => auto-session, session-lens
---------------------------------------------------------------
keymap("n", "<leader>sl", ":SessionsLoad<CR>", opts)
keymap("n", "<leader>ss", ":SessionsSave<CR>", opts)
keymap("n", "<leader>sd", ":SessionsStop<CR>", opts)

---------------------------------------------------------------
-- => vim-illuminate
---------------------------------------------------------------
keymap("n", "<M-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts)
keymap("n", "<M-S-n>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts)
keymap("v", "<M-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts)
keymap("v", "<M-S-n>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts)

---------------------------------------------------------------
-- => hop.nvim
---------------------------------------------------------------
keymap("", "sf", "<cmd>HopChar2<CR>", opts)
keymap("", "sg", "<cmd>HopChar1<CR>", opts)
keymap("", "sj", "<cmd>HopLineStartAC<CR>", opts)
keymap("", "sk", "<cmd>HopLineStartBC<CR>", opts)
keymap("", "s/", "<cmd>HopPattern<CR>", opts)

---------------------------------------------------------------
-- => bufferline.nvim
---------------------------------------------------------------
-- keymap("n", "]b", ":BufferLineCycleNext<CR>", opts)
-- keymap("n", "[b", ":BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<M-.>", ":BufferLineCycleNext<CR>", opts)
-- keymap("i", "<M-.>", "<Esc>:BufferLineCycleNext<CR>", opts)
-- keymap("n", "<M-,>", ":BufferLineCyclePrev<CR>", opts)
-- keymap("i", "<M-,>", "<Esc>:BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<A-S->>", ":BufferLineMoveNext<CR>", opts)
-- keymap("n", "<A-S-<>", ":BufferLineMovePrev<CR>", opts)
-- keymap("n", "Q", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", opts)