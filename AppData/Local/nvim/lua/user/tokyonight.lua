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
    colors.bg_statusline = "#121218"
  end,
  on_highlights = function(hl, colors)
    hl.TabLineSel = { bg = "#1A2336" }
  end,
})
