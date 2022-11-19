require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = true, -- Force no italic
  -- no_bold = true, -- Force no bold
  styles = {
    comments = {},
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    cmp = true,
    gitsigns = false,
    nvimtree = true,
    telescope = true,
    treesitter = true,
    illuminate = true,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
  highlight_overrides = {
    mocha = function(mocha)
      return {
        -- NormalFloat = { bg = mocha.mantle },
        LspInfoBorder = { fg = mocha.blue },
        Pmenu = { bg = "#1a1a2b" },
        Comment = { fg = "#767a96" },
        ["@field.lua"] = { fg = mocha.teal },
        ["@constructor.lua"] = { fg = mocha.lavender }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.
        -- remove bold
        ErrorMsg = { fg = mocha.red, style = {} }, -- error messages on the command line
        -- remove underline
        ["@text.uri"] = { fg = mocha.rosewater, style = {} }, -- urls, links and emails
      }
    end,
  },
  color_overrides = {
    mocha = {
      base = "#12121d",
    },
  },
  custom_highlights = {},
})
