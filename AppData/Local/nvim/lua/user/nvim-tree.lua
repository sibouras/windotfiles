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
    hide_root_folder = false,
    side = "right",
    mappings = {
      custom_only = false,
      list = {
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
        { key = "s", action = "" },
        { key = "o", action = "system_open" },
        {
          key = "e",
          action = "prev_win",
          action_cb = function()
            vim.cmd.wincmd("p")
          end,
        },
        {
          key = "i",
          action = "print_the_node_path",
          action_cb = function(node)
            print(node.absolute_path)
          end,
        },
      },
    },
    number = false,
    relativenumber = false,
    -- float = {
    --   enable = false,
    --   quit_on_focus_loss = true,
    --   open_win_config = {
    --     relative = "editor",
    --     border = "rounded",
    --     width = 30,
    --     height = 30,
    --     row = 1,
    --     col = 1,
    --   },
    -- },
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local _width = screen_w * 0.5
        local _height = screen_h * 0.8
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

local map = vim.keymap.set

map("n", "<M-e>", ":NvimTreeToggle<CR>")
map("n", "<leader>e", ":NvimTreeFindFileToggle<CR>")
map("n", "<leader>mn", function()
  require("nvim-tree.api").marks.navigate.next()
end)
map("n", "<leader>mp", function()
  require("nvim-tree.api").marks.navigate.prev()
end)
map("n", "<leader>ms", function()
  require("nvim-tree.api").marks.navigate.select()
end)
