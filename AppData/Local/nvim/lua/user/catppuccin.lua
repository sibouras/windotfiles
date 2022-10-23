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
        Comment = { fg = "#767a96" },
        Pmenu = { bg = "#1a1a2b" },
        ErrorMsg = { fg = mocha.red, style = { "bold" } }, -- error messages on the command line
        ["@parameter"] = { fg = mocha.maroon, style = {} }, -- For parameters of a function.
        ["@text.literal"] = { fg = mocha.teal, style = {} }, -- used for inline code in markdown and for doc in python (""")
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
