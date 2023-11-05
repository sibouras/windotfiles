local function augroup(name)
  return vim.api.nvim_create_augroup('MyGroup_' .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  desc = 'disable auto-comment on o and O and enter',
  group = augroup('formatoptions'),
  callback = function()
    vim.cmd('set formatoptions-=cro')
  end,
})

-- automatically open quickfix window and don't jump to first match
vim.cmd([[command! -nargs=+ Grep execute 'silent grep! <args>' | copen]])

vim.api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'close some filetypes with <q>',
  pattern = { 'qf', 'help', 'man', 'spectre_panel', 'startuptime', 'Redir' },
  group = augroup('close_with_q'),
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<Cmd>close<CR>', { buffer = event.buf, silent = true })
  end,
})
