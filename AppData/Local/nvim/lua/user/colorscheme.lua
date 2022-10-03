require("tokyonight").setup({
  style = "night",
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  },
  sidebars = { "lspinfo", "null-ls-info" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  on_colors = function(colors)
    colors.bg = "#16161e"
    colors.bg_dark = "#121218"
    colors.bg_popup = "#121218"
    colors.bg_sidebar = "#121218"
    colors.bg_highlight = "#24283b"
    colors.bg_statusline = "#0b0b0f"
  end,
  on_highlights = function(hl, colors)
    hl.TabLineSel = { bg = "#1A2336" }
  end,
})

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.cmd([[
  highlight Underlined guisp=#7aa2f7 " change markdown link color
  highlight markdownLinkText guisp=#7aa2f7
  highlight WinSeparator guifg=#3b4261
  highlight PounceAccept gui=bold guifg=#ffffff guibg=#3F00FF
  highlight PounceAcceptBest gui=bold guifg=#ffffff guibg=#FF2400
]])
