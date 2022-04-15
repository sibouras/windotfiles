-- nvim builtin highlight
vim.cmd([[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
  augroup END
]])

-- disable auto-comment on o and O and enter
vim.cmd([[
  augroup formatoptions
    autocmd!
    autocmd BufEnter * setlocal formatoptions -=o formatoptions -=r
  augroup END
]])

-- Only show the cursor line in the active buffer.
-- vim.cmd([[
--   augroup CursorLine
--       au!
--       au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
--       au WinLeave * setlocal nocursorline
--   augroup END
-- ]])

-- Automatically equalize splits when Vim is resized
vim.cmd([[
  autocmd VimResized * wincmd =
]])

-- automatically open quickfix window and don't jump to first match
vim.cmd([[command! -nargs=+ Grep execute 'silent grep! <args>' | copen]])

-- create new file with :e even if directory doesn't exist
vim.cmd([[
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END
]])

-- keep window position when switching buffers
-- https://stackoverflow.com/questions/4251533/vim-keep-window-position-when-switching-buffers
vim.cmd([[
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
]])
