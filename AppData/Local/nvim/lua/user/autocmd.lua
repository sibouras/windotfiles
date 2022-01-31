vim.cmd([[
  " nvim builtin highlight
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
  augroup END

  " disable auto-comment on o and O and enter
  augroup formatoptions
    autocmd!
    autocmd BufEnter * setlocal formatoptions -=o formatoptions -=r
  augroup END

  " Only show the cursor line in the active buffer.
  " augroup CursorLine
  "     au!
  "     au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  "     au WinLeave * setlocal nocursorline
  " augroup END

  " Automatically equalize splits when Vim is resized
  autocmd VimResized * wincmd =
]])
