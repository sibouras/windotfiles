-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup({
  disable_netrw = false,
  hijack_netrw = true,
  hijack_cursor = false,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  open_on_tab = false,
  update_cwd = true,
  respect_buf_cwd = false,
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filesystem_watchers = {
    enable = true,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
        { key = "s", action = "" },
        { key = "o", action = "system_open" },
      },
    },
    number = false,
    relativenumber = false,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local _width = screen_w * 0.7
        local _height = screen_h * 0.9
        local width = math.floor(_width)
        local height = math.floor(_height)
        local center_y = ((vim.opt.lines:get() - _height) / 2) - vim.opt.cmdheight:get()
        local center_x = (screen_w - _width) / 2
        local layouts = {
          center = {
            anchor = "NW",
            relative = "editor",
            border = "single",
            row = center_y,
            col = center_x,
            width = width,
            height = height,
          },
        }
        return layouts.center
      end,
    },
  },
  renderer = {
    full_name = true,
    icons = {
      glyphs = {
        git = {
          -- unstaged = "",
          -- staged = "S",
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$", "^.nvim$", "^node_modules$" },
    exclude = {},
  },
})
