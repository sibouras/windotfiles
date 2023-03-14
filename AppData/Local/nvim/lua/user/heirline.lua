local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local function setup_colors()
  return {
    bright_bg = utils.get_highlight("Folded").bg,
    dark_bg = utils.get_highlight("CursorLine").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("diffRemoved").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,
    statusline_fg = utils.get_highlight("StatusLine").fg,
    statusline_bg = utils.get_highlight("StatusLine").bg,
  }
end

require("heirline").load_colors(setup_colors())

--> Crash course: the ViMode

local ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()

    -- execute this only once, this is required if you want the ViMode
    -- component to be updated on operator pending mode
    if not self.once then
      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*:*o",
        command = "redrawstatus",
      })
      self.once = true
    end
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = "red",
      i = "green",
      v = "cyan",
      V = "cyan",
      ["\22"] = "cyan",
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      R = "orange",
      r = "orange",
      ["!"] = "red",
      t = "red",
    },
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    return " %2(" .. self.mode_names[self.mode] .. "%)"
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors[mode], bold = true }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- This is not required in any way, but it's there, and it's a small
  -- performance improvement.
  update = {
    "ModeChanged",
  },
}

--> Crash course part 2: FileName and friends

local FileNameBlock = {
  -- let's first set up some attributes needed by this component and it's children
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}
-- We can now define some children separately and add them later

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  provider = function(self)
    -- first, trim the pattern relative to the current directory. For other
    -- options, see :h filename-modifers
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    if filename == "" then
      return "[No Name]"
    end
    -- now, if the filename would occupy more than 1/4th of the available
    -- space, we trim the file path to its initials
    -- See Flexible Components section below for dynamic truncation
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "",
    hl = { fg = "orange" },
  },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = "cyan", bold = true, force = true }
    end
  end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
  FileNameBlock,
  FileIcon,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  unpack(FileFlags) -- A small optimisation, since their parent does nothing
)

--> FileType, FileEncoding and FileFormat

local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = "Type",
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    -- return enc ~= "utf-8" and enc:upper()
    return enc:upper()
  end,
}

local FileFormat = {
  provider = function()
    local symbols = {
      unix = "", -- e712
      dos = "", -- e70f
      mac = "", -- e711
    }
    local fmt = vim.bo.fileformat
    -- return fmt ~= "unix" and fmt:upper()
    return symbols[fmt] or fmt:upper()
  end,
}

--> Cursor position: Ruler and ScrollBar

-- We're getting minimalists here!
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  -- provider = "%7(%l/%3L%):%2c %P",
  provider = "%(%l%):%2c %P",
  hl = { fg = "orange" },
}

local ScrollBar = {
  static = {
    sbar = { " ", "▁", "▂", "▃", "▄", "▅", "▆", "▇" },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = "blue", bg = "bright_bg" },
}

--> LSP

--- Get a list of registered null-ls providers for a given filetype
-- @param filetype the filetype to search null-ls for
-- @return a list of null-ls sources
local function null_ls_providers(filetype)
  local registered = {}
  -- try to load null-ls
  local sources_avail, sources = pcall(require, "null-ls.sources")
  if sources_avail then
    -- get the available sources of a given filetype
    for _, source in ipairs(sources.get_available(filetype)) do
      -- get each source name
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end
  end
  -- return the found null-ls sources
  return registered
end

--- Get the null-ls sources for a given null-ls method
-- @param filetype the filetype to search null-ls for
-- @param method the null-ls method (check null-ls documentation for available methods)
-- @return the available sources for the given filetype and method
local function get_null_ls_sources(filetype, method)
  local methods_avail, methods = pcall(require, "null-ls.methods")
  return methods_avail and null_ls_providers(filetype)[methods.internal[method]] or {}
end

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach", "BufWinEnter" },

  -- You can keep it simple,
  -- provider = " [LSP]",

  -- Or complicate things a bit and get the servers names
  provider = function()
    -- local names = {}
    -- for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    --   table.insert(names, server.name)
    -- end
    -- return " [" .. table.concat(names, " ") .. "]"
    local expand_null_ls = true
    local buf_client_names = {}
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      if client.name == "null-ls" and expand_null_ls then
        local null_ls_sources = {}
        for _, type in ipairs({ "FORMATTING", "DIAGNOSTICS" }) do
          for _, source in ipairs(get_null_ls_sources(vim.bo.filetype, type)) do
            null_ls_sources[source] = true
          end
        end
        vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources))
      else
        table.insert(buf_client_names, client.name)
      end
    end
    -- return table.concat(buf_client_names, ", ")
    return " [" .. table.concat(buf_client_names, " ") .. "]"
  end,
  hl = { fg = "#cfc9c2", bold = false },
}

local LSPSimple = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach", "BufWinEnter" },
  provider = " [LSP]",
  hl = { fg = "gray" },
}

--> Treesitter

local ts_avail, ts = pcall(require, "nvim-treesitter.parsers")

local TreesitterActive = {
  -- update = { "OptionSet", pattern = "syntax" },
  update = { "BufWinEnter" },

  provider = function()
    if not (ts_avail and ts.has_parser()) then
      return
    end
    local buf = vim.api.nvim_get_current_buf()
    local highlighter = require("vim.treesitter.highlighter")
    return highlighter.active[buf] and "綠TS " or ""
  end,
  hl = { fg = "green", bold = false },
}

local TSHl = {
  update = { "OptionSet", pattern = "syntax" },
  init = function(self)
    if not rawget(self, "once") then
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          self._win_cache = nil
        end,
      })
      self.once = true
    end
  end,
  hl = function()
    local buf = vim.api.nvim_get_current_buf()
    local highlighter = require("vim.treesitter.highlighter")
    local fg = highlighter.active[buf] and "green" or "red"
    return { fg = fg, bold = false }
  end,
  provider = function()
    if not (ts_avail and ts.has_parser()) then
      return
    end
    -- return "TS " .. os.clock() .. " "
    return "綠TS "
  end,
}

--> Nvim Navic

-- Full nerd (with icon colors)!
-- Be careful, this implementation will work only if this component
-- is displayied in a single window, and it is the current window.
local Navic = {
  condition = function()
    return require("nvim-navic").is_available()
  end,
  update = "CursorMoved",
  provider = "",
  static = {
    type_hl = {
      File = "Directory",
      Module = "@include",
      Namespace = "@namespace",
      Package = "@include",
      Class = "@structure",
      Method = "@method",
      Property = "@property",
      Field = "@field",
      Constructor = "@constructor",
      Enum = "@field",
      Interface = "@type",
      Function = "@function",
      Variable = "@variable",
      Constant = "@constant",
      String = "@string",
      Number = "@number",
      Boolean = "@boolean",
      Array = "@field",
      Object = "@type",
      Key = "@keyword",
      Null = "@comment",
      EnumMember = "@field",
      Struct = "@structure",
      Event = "@keyword",
      Operator = "@operator",
      TypeParameter = "@type",
    },
    -- bit operation dark magic, see below...
    enc = function(a, b)
      return bit.bor(bit.lshift(a, 16), b)
    end,
    dec = function(c)
      return { bit.rshift(c, 16), bit.band(c, 65535) }
    end,
  },
  init = function(self)
    local data = require("nvim-navic").get_data() or {}
    local children = {}
    -- separater after filename
    if #data >= 1 then
      table.insert(children, { provider = " > ", hl = { fg = "bright_fg" } })
    end
    -- create a child for each level
    for i, d in ipairs(data) do
      -- encode line and column numbers into a single integer
      local pos = self.enc(d.scope.start.line, d.scope.start.character)
      local child = {
        {
          provider = d.icon,
          hl = self.type_hl[d.type],
        },
        {
          -- escape `%`s (elixir) and buggy default separators
          provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
          -- highlight icon only or location name as well
          -- hl = self.type_hl[d.type],

          on_click = {
            -- pass the encoded position through minwid
            minwid = pos,
            callback = function(_, minwid)
              -- decode
              vim.api.nvim_win_set_cursor(0, self.dec(minwid))
            end,
            name = "heirline_navic",
          },
        },
      }
      -- add a separator only if needed
      if #data > 1 and i < #data then
        table.insert(child, {
          provider = " > ",
          hl = { fg = "bright_fg" },
        })
      end
      table.insert(children, child)
    end
    -- instantiate the new child, overwriting the previous one
    self[1] = self:new(children, 1)
  end,
  hl = { fg = "gray" },
}

--> Diagnostics

local Diagnostics = {
  condition = conditions.has_diagnostics,

  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = "![",
  },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
  {
    provider = "]",
  },
}

--> Git

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "purple" },

  { -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = false },
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = "git_add" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = "git_del" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = "git_change" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
  },
}

--> Terminal Name

local TerminalName = {
  -- we could add a condition to check that buftype == 'terminal'
  -- or we could do that later (see #conditional-statuslines below)
  provider = function()
    local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
    return " " .. tname
  end,
  hl = { fg = "blue", bold = true },
}

--> Help FileName

local HelpFilename = {
  condition = function()
    return vim.bo.filetype == "help"
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ":t")
  end,
  hl = "Directory",
}

--> Spell

local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = " SPELL",
  hl = { bold = true, fg = "orange" },
}

--> Putting it all together: Conditional Statuslines

local Align = { provider = "%=" }
local Space = { provider = " " }

ViMode = utils.surround({ "", "" }, "dark_bg", { ViMode })

Ruler = utils.surround({ "", "" }, "dark_bg", { Ruler })

Git = {
  condition = function()
    return conditions.is_git_repo()
  end,
  Space,
  utils.surround({ "", "" }, "dark_bg", { Git }),
}

local DefaultStatusline = {
  ViMode,
  Spell,
  -- Space,
  -- FileNameBlock,
  Git,
  Space,
  -- {
  --   condition = function()
  --     return vim.g.diagnostics_active
  --   end,
  --   Diagnostics,
  -- },
  Diagnostics,
  Align,
  -- { flexible = 3, LSPSimple, { provider = "" } },
  LSPSimple,
  Space,
  -- TreesitterActive,
  TSHl,
  FileFormat,
  Space,
  Ruler,
}

local InactiveStatusline = {
  condition = conditions.is_not_active,
  FileType,
  Space,
  FileName,
  Align,
}

local SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { "nofile", "prompt", "help", "quickfix" },
      filetype = { "fugitive", "harpoon" },
    })
  end,
  Space,
  FileType,
  Space,
  HelpFilename,
  Align,
}

local TerminalStatusline = {
  condition = function()
    return conditions.buffer_matches({ buftype = { "terminal" } })
  end,
  hl = { bg = "statusline_bg" },
  -- Quickly add a condition to the ViMode to only show it when buffer is active!
  { condition = conditions.is_active, ViMode, Space },
  FileType,
  Space,
  TerminalName,
  Align,
}

local StatusLines = {
  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,

  -- the first statusline with no condition, or which condition returns true is used.
  -- think of it as a switch case with breaks to stop fallthrough.
  fallthrough = false,

  SpecialStatusline,
  TerminalStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

--> Winbar

local WinBars = {
  fallthrough = false,
  { -- Hide the winbar for special buffers
    condition = function()
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
        filetype = { "fugitive" },
      })
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
  { -- An inactive winbar for regular files
    condition = function()
      return not conditions.is_active()
    end,
    utils.surround({ "", "" }, "dark_bg", { hl = { fg = "gray", force = true }, FileNameBlock }),
  },
  { -- A winbar for regular files
    condition = function()
      return conditions.is_active()
    end,
    utils.surround({ "", "" }, "dark_bg", FileNameBlock),
    { provider = "%<" }, -- this means that the winbar is cut here when there's not enough space
    Navic,
  },
}

require("heirline").setup({
  statusline = StatusLines,
  winbar = WinBars,
  opts = {
    -- if the callback returns true, the winbar will be disabled for that window
    -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
    disable_winbar_cb = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains({ "prompt", "nofile", "help", "quickfix" }, vim.bo[buf].buftype)
      local filetype = vim.tbl_contains({ "gitcommit", "fugitive", "Trouble", "packer" }, vim.bo[buf].filetype)
      return buftype or filetype
    end,
  },
})

vim.api.nvim_create_augroup("Heirline", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local colors = setup_colors()
    utils.on_colorscheme(colors)
  end,
  group = "Heirline",
})
