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
      enable = false,
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
})
