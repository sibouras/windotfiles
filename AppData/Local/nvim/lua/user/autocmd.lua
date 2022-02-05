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
