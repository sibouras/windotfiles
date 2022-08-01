local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local colors = {
  bg = "#2F354D",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 40
end

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  -- symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = hide_in_width,
}

local encoding = {
  "encoding",
  cond = hide_in_width,
}

local fileformat = {
  "fileformat",
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  colored = true,
  icon_only = true,
  padding = { right = 2, left = 1 },
  cond = hide_in_width,
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "Outline" },
    ignore_focus = { "", "NvimTree", "TelescopePrompt" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "filename", color = { bg = colors.bg } } },
    lualine_c = { "branch", diff, "diagnostics" },
    lualine_x = {
      -- encoding,
      fileformat,
      filetype,
    },
    lualine_y = { { "progress", color = { bg = colors.bg } } },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
