-- nvim builtin highlight
-- vim.cmd([[
--   augroup highlight_yank
--     autocmd!
--     autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
--   augroup END
-- ]])
-- highlight on yank with lua
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- disable auto-comment on o and O and enter
-- vim.cmd([[
--   augroup formatoptions
--     autocmd!
--     autocmd BufEnter * setlocal formatoptions -=o formatoptions -=r
--   augroup END
-- ]])
-- with lua
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
    vim.cmd([[set formatexpr=\"]]) -- empty formatexpr so gq uses formatoptions
  end,
})

-- Only show the cursor line in the active buffer.
-- vim.cmd([[
--   augroup CursorLine
--       au!
--       au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
--       au WinLeave * setlocal nocursorline
--   augroup END
-- ]])

-- hide cursor line when nvim loses focus
vim.cmd([[
  augroup CursorLine
      au!
      au FocusGained * setlocal cursorline
      au FocusLost * setlocal nocursorline
      " au FocusGained * highlight Cursor guifg=black guibg=#7aa2f7
      " au FocusLost * highlight Cursor guifg=black guibg=#546faa
  augroup END
]])

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
-- https://vim.fandom.com/wiki/Avoid_scrolling_when_switch_buffers
-- can be replaced with :set jumpoptions=view (added in 0.8) but `:b buffer` doesn't reset the view
vim.cmd([[
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
  if !exists("w:SavedBufView")
    let w:SavedBufView = {}
  endif
  let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
  let buf = bufnr("%")
  if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
    let v = winsaveview()
    let atStartOfFile = v.lnum == 1 && v.col == 0
    if atStartOfFile && !&diff
      call winrestview(w:SavedBufView[buf])
    endif
    unlet w:SavedBufView[buf]
  endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
  autocmd BufLeave * call AutoSaveWinView()
  autocmd BufEnter * call AutoRestoreWinView()
endif
]])

-- source: https://github.com/ecosse3/nvim/blob/master/lua/autocmds.lua
-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

-- Enable spell checking for certain file types
-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" })

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "startuptime", "Redir" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd([[
      " set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
  end,
})

-- Set wrap and spell in markdown and gitcommit
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "gitcommit", "markdown" },
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.opt_local.spell = true
--   end,
-- })

-- insert mode when switching to terminal
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "term://*",
  command = "startinsert",
})

-- cursorline in harpoon
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "harpoon",
  command = "setlocal cursorline",
})
