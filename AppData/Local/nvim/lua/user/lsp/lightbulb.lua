-- show a lightbulb if a code action is available at the current cursor position
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
