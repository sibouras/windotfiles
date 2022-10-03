local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  return
end

local map = vim.keymap.set
local opts = { silent = true }

saga.init_lsp_saga({
  symbol_in_winbar = {
    in_custom = true,
  },
  finder_action_keys = {
    open = "<CR>",
    vsplit = "s",
    split = "v",
    tabe = "t",
    quit = "q",
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
  code_action_lightbulb = {
    enable = true,
  },
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
map("n", "<leader>lr", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- Code action
map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

-- Rename
map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
map("n", "<leader>lf", "<cmd>Lspsaga peek_definition<CR>", opts)

-- Outline
map("n", "<leader>to", "<cmd>LSoutlineToggle<CR>", opts)

-- Hover Doc
-- map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

-- Show line diagnostics
map("n", "<leader>dg", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show cursor diagnostic
map("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Diagnsotic jump can use `<c-o>` to jump back
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Only jump to error
map("n", "[D", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
map("n", "]D", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Example:
local function get_file_name(include_path)
  local file_name = require("lspsaga.symbolwinbar").get_file_name()
  if vim.fn.bufname("%") == "" then
    return ""
  end
  if include_path == false then
    return file_name
  end
  -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  local path_list = vim.split(string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""), sep)
  local file_path = ""
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
  end
  return file_path .. file_name
end

local function config_winbar_or_statusline()
  local exclude = {
    ["terminal"] = true,
    ["toggleterm"] = true,
    ["prompt"] = true,
    ["NvimTree"] = true,
    ["help"] = true,
  } -- Ignore float windows and exclude filetype
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    vim.wo.winbar = ""
  else
    local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
    local sym
    if ok then
      sym = lspsaga.get_symbol_node()
    end
    local win_val = ""
    win_val = get_file_name(false) -- set to true to include path
    if sym ~= nil then
      win_val = win_val .. sym
    end
    vim.wo.winbar = " " .. win_val
    -- if work in statusline
    -- vim.wo.stl = win_val
  end
end

local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

vim.api.nvim_create_autocmd(events, {
  pattern = "*",
  callback = function()
    config_winbar_or_statusline()
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LspsagaUpdateSymbol",
  callback = function()
    config_winbar_or_statusline()
  end,
})
