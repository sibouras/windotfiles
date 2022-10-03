local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
  print("nvim-navic not found")
  return
end

navic.setup({
  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
})

local function is_empty(s)
  return s == nil or s == ""
end

local function get_buf_option(opt)
  local buf_option_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not buf_option_ok then
    return nil
  else
    return buf_option
  end
end

local function get_filename()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")

  if not is_empty(filename) then
    local file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

    local hl_group = "FileIconColor" .. extension
    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })

    if is_empty(file_icon) then
      file_icon = ""
    end

    local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local function get_navic()
  -- local status_navic_ok, navic = pcall(require, "nvim-navic")
  -- if not status_navic_ok then
  --   return ""
  -- end

  local navic_location_ok, navic_location = pcall(navic.get_location, {})
  if not navic_location_ok then
    return ""
  end

  if not navic.is_available() or navic_location == "error" then
    return ""
  end

  if not is_empty(navic_location) then
    return ">" .. " " .. navic_location
  else
    return ""
  end
end

local winbar_filetype_exclude = {
  "terminal",
  "toggleterm",
  "prompt",
  "NvimTree",
  "help",
  "harpoon",
  "packer",
  "startuptime",
}

local function get_winbar()
  if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
    return
  end

  local value = get_filename()
  local navic_added = false
  if not is_empty(value) then
    local navic_value = get_navic()
    value = value .. " " .. navic_value
    if not is_empty(navic_value) then
      navic_added = true
    end
  end

  if not is_empty(value) and get_buf_option("mod") then
    local mod = "%#LspCodeLens#" .. "" .. "%*"
    if navic_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not is_empty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local local_status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not local_status_ok then
    return
  end
end

vim.api.nvim_create_augroup("_winbar", {})
vim.api.nvim_create_autocmd(
  { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
  {
    group = "_winbar",
    callback = function()
      -- local local_status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
      -- if not local_status_ok then
      get_winbar()
      -- end
    end,
  }
)
