vim.g.tokyonight_style = "night"

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.cmd([[
  highlight Underlined guisp=#7aa2f7 " change vimwiki link color
  highlight WinSeparator guifg=#3b4261
  highlight PounceAccept gui=bold guifg=#ffffff guibg=#3F00FF
  highlight PounceAcceptBest gui=bold guifg=#ffffff guibg=#FF2400
]])
