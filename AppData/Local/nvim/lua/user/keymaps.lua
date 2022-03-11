local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quit vim
map("n", "<M-F4>", ":qa!<CR>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Navigate buffers
map("i", "<M-w>", "<esc><C-^>")
map("n", "<M-w>", "<C-^>")
map("n", "<M-d>", ":BDelete! this<CR>")
map("n", "]b", ":bnext")
map("n", "[b", ":bprevious<CR>")
map("n", "<M-.>", ":bnext<CR>")
map("i", "<M-.>", "<Esc>:bnext<CR>")
map("n", "<M-,>", ":bprevious<CR>")
map("i", "<M-,>", "<Esc>:bprevious<CR>")
map("n", "Q", ":BDelete hidden<CR>")

-- Navigate tabs
-- Number + , to select a tab, i.e. type 1, to select the first tab.
for i = 1, 5 do
  map("n", i .. ",", i .. "gt")
end

-- Move text up and down(using nvim-gomove instead)
-- map("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- map("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- df to escape
map("i", "df", "<ESC>")

-- quick save
map("n", "<M-s>", ":w<CR>")
map("i", "<M-s>", "<Esc>:w<CR>")

-- Ctrl-Backspace to delete the previous word
map("i", "<C-BS>", "<C-W>")
map("c", "<C-BS>", "<C-W>", { silent = false })

-- ctrl-z to undo
map("i", "<C-z>", "<C-o>:u<CR>")

-- undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- jumplit mutations
vim.cmd([[
 nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
 nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
]])

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z")

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
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { silent = false })

-- use . to repeat a regular c-prefixed command as if it were perforced using cgn.
map("n", "g.", '/\\V<C-r>"<CR>cgn<C-a><Esc>', { silent = false })
-- search for the word under the cursor and perform cgn on it
map("n", "cg*", "*Ncgn", { silent = false })

-- Double space over word to find and replace.
map("n", "<leader>rw", [[:%s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>]], { silent = false })

-- Press * to search for the term under the cursor or a visual selection and
-- then press a key below to replace all instances of it in the current file.
map("n", "<leader>rr", ":%s///g<Left><Left>", { silent = false })
map("n", "<leader>rc", ":%s///gc<Left><left><Left>", { silent = false })

-- The same as above but instead of acting on the whole file it will be
-- restricted to the previously visually selected range.
map("x", "<leader>rr", ":s///g<Left><Left>", { silent = false })
map("x", "<leader>rc", ":s///gc<Left><left><Left>", { silent = false })

-- Toggle spell check.
map("n", "<F5>", ":setlocal spell!<CR>")

-- delete all trailing whitespace
map("n", "<F6>", [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]])

-- Toggle visually showing all whitespace characters.
map("n", "<F7>", ":set list!<CR>")
map("i", "<F7>", "<C-o>:set list!<CR>")

-- Toggle relative line numbers and regular line numbers.
map("n", "<F8>", ":set invrelativenumber<CR>")

-- Navigate quickfix list
map("n", "[q", ":cprevious<CR>")
map("n", "]q", ":cnext<CR>")

-- yank to system clipboard
map("n", "<M-y>", '"+y')
map("v", "<M-y>", '"+y')
map("n", "<M-p>", '"+p')
map("v", "<M-p>", '"+p')
map("i", "<M-p>", "<C-r>+")
map("c", "<M-p>", "<C-r>+")
map("n", "<M-S-p>", '"+P')
map("v", "<M-S-p>", '"+P')

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
map("n", "sp", "`[v`]")

-- Quickly edit your macros(from vim-galore)
map("n", "<leader>m", ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- unexpected behavior when pasting above highlighted text(broken mapping)
-- map("v", "p", '"_dP')

-- format
map("n", "<M-S-f>", ":Format<cr>")

-- remove highlight
map("n", "<esc>", ":noh<cr>")

-- Quickly add empty lines
-- map("n", "[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
-- map("n", "]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>")
map("n", "[<space>", "O<Esc>")
map("n", "]<space>", "o<Esc>")

-- faster horizontal navigation
map("n", "zl", "10zl")
map("n", "zh", "10zh")

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
map("n", "<leader>tk", ":tabe $LOCALAPPDATA/nvim/lua/user/keymaps.lua<CR>")

vim.cmd([[
iab <expr> t/ strftime('TODO(' . '%Y-%m-%d):')
" Open help and man pages in a tab:
cab help tab help
]])

map("v", "<leader>cy", ":call functions#CompleteYank()<CR>")
map("x", "@", ":<C-u>call functions#ExecuteMacroOverVisualRange()<CR>")

----------------------------------
--- definition of new commands ---
----------------------------------
vim.cmd([[
command! TS silent! call functions#T2S()
command! ST silent! call functions#S2T()
command! Rf silent! call functions#ReplaceFile()
command! Rename call functions#RenameFile()
command! Remove call functions#RemoveFile()
command! -nargs=1 -complete=command -bar -range Redir silent call functions#Redir(<q-args>, <range>, <line1>, <line2>)
]])

-----------------------------------
------------- Plugins -------------
-----------------------------------

---------------------------------------------------------------
-- => telescope.nvim
---------------------------------------------------------------
-- map("n", "<leader>f", "<cmd>Telescope find_files<cr>")
-- map(
--   "n",
--   "<leader>f",
--   "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
-- )
map(
  "n",
  "<leader>fd",
  "<cmd>lua require'telescope.builtin'.find_files({ cwd = '~/.config/symlinks', prompt_title = 'Dotfiles' })<cr>"
)
map(
  "n",
  "<leader>ff",
  "<cmd>lua require'telescope.builtin'.find_files({ cwd = vim.fn.expand('%:p:h'), prompt_title = 'From Current Buffer' })<cr>"
)
map("n", "<leader>fs", ":Telescope find_files<CR>")
map("n", "<leader>fe", ":Telescope resume<CR>")
-- map(
--   "n",
--   "<leader>b",
--   ":lua require'telescope.builtin'.buffers{ sort_lastused = true, ignore_current_buffer = false }<CR>"
-- )
map("n", "<leader>b", ":Telescope buffers<CR>")
map("n", "<leader>fo", ":Telescope oldfiles<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fk", ":Telescope keymaps<CR>")
map("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>")
map("n", "q/", ":Telescope search_history<CR>")
map("n", "q:", ":Telescope command_history<CR>")
map("n", "<leader>p", ":Telescope workspaces<CR>")
map("n", "<leader>fn", ":Telescope neoclip<CR>")
map("n", "<leader>lr", ":Telescope lsp_references<CR>")
map("n", "<leader>ld", ":Telescope lsp_definitions<CR>")
map("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>")
map("n", "<leader>lt", ":Telescope treesitter<CR>")

---------------------------------------------------------------
-- => lir.nvim, nvim-tree.nvim
---------------------------------------------------------------
-- map("n", "<leader>e", ":lua require'lir.float'.toggle()<CR>")
map("n", "<M-e>", ":NvimTreeToggle<CR>")
map("n", "<leader>e", ":NvimTreeFindFileToggle<CR>")

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

---------------------------------------------------------------
-- => harpoon.nvim
---------------------------------------------------------------
map("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
map("n", "<M-f>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
-- map("n", "<leader>hc", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>")
for i = 1, 5 do
  map("n", "<leader>" .. i, ":lua require('harpoon.ui').nav_file(" .. i .. ")<CR>")
end

--------------------------------------------------------------
-- => auto-session, session-lens
---------------------------------------------------------------
map("n", "<leader>sl", ":SessionsLoad<CR>")
map("n", "<leader>ss", ":SessionsSave<CR>")
map("n", "<leader>sd", ":SessionsStop<CR>")

---------------------------------------------------------------
-- => vim-illuminate
---------------------------------------------------------------
map("n", "<M-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
map("n", "<M-S-n>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')
map("v", "<M-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
map("v", "<M-S-n>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')

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
map("", "sf", "<cmd>Pounce<CR>")
map("", "S", "<cmd>PounceRepeat<CR>")

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
