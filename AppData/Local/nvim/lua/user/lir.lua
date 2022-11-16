local status_ok, lir = pcall(require, "lir")
if not status_ok then
  return
end

local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

local function goto_git_root()
  local dir = require("lspconfig.util").find_git_ancestor(vim.fn.getcwd())
  if dir == nil or dir == "" then
    return
  end
  vim.cmd("e " .. dir)
end

lir.setup({
  show_hidden_files = true,
  ignore = { "^.git$", "^.nvim$", "^node_modules$" },
  devicons_enable = true,
  mappings = {
    ["l"] = actions.edit,
    ["H"] = goto_git_root,
    ["~"] = function()
      vim.cmd("edit " .. vim.fn.expand("$HOME"))
    end,
    ["<cr>"] = actions.edit,
    ["<C-s>"] = actions.split,
    ["<C-v>"] = actions.vsplit,
    ["<C-t>"] = actions.tabedit,

    ["h"] = actions.up,
    ["q"] = actions.quit,
    ["<esc>"] = actions.quit,

    ["A"] = actions.mkdir,
    ["a"] = actions.newfile,
    ["r"] = actions.rename,
    ["c"] = actions.cd,
    ["Y"] = actions.yank_path,
    ["."] = actions.toggle_show_hidden,
    ["d"] = actions.delete,

    ["J"] = function()
      mark_actions.toggle_mark()
      vim.cmd("normal! j")
    end,
    ["C"] = clipboard_actions.copy,
    ["X"] = clipboard_actions.cut,
    ["P"] = clipboard_actions.paste,

    ["B"] = require("lir.bookmark.actions").list,
    ["ba"] = require("lir.bookmark.actions").add,
  },
  float = {
    winblend = 0,
    curdir_window = {
      enable = false,
      highlight_dirname = true,
    },

    -- You can define a function that returns a table to be passed as the third
    -- argument of nvim_open_win().
    win_opts = function()
      local screen_w = vim.opt.columns:get()
      local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
      local _width = screen_w * 0.5
      local _height = screen_h * 0.8
      local width = math.floor(_width)
      local height = math.floor(_height)
      local center_y = ((vim.opt.lines:get() - _height) / 2) - vim.opt.cmdheight:get()
      local center_x = (screen_w - _width) / 2
      return {
        border = {
          "+",
          "─",
          "+",
          "│",
          "+",
          "─",
          "+",
          "│",
        },
        row = center_y,
        col = center_x,
        width = width,
        height = height,
      }
    end,
  },
  hide_cursor = true,
  on_init = function()
    -- use visual mode
    vim.api.nvim_buf_set_keymap(
      0,
      "x",
      "J",
      ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
      { noremap = true, silent = true }
    )

    -- echo cwd
    -- vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
  end,
})

-- custom folder icon
require("nvim-web-devicons").set_icon({
  lir_folder_icon = {
    icon = "",
    color = "#7ebae4",
    name = "LirFolderNode",
  },
})

local b_actions = require("lir.bookmark.actions")
require("lir.bookmark").setup({
  bookmark_path = "~/.lir_bookmark",
  mappings = {
    ["<CR>"] = b_actions.edit,
    ["l"] = function()
      b_actions.edit()
      vim.cmd("bd .lir_bookmark")
    end,
    ["<C-s>"] = b_actions.split,
    ["<C-v>"] = b_actions.vsplit,
    ["<C-t>"] = b_actions.tabedit,
    ["<C-e>"] = b_actions.open_lir,
    ["B"] = function()
      b_actions.open_lir()
      vim.cmd("bd .lir_bookmark")
    end,
    ["q"] = function()
      b_actions.open_lir()
      vim.cmd("bd .lir_bookmark")
    end,
  },
})

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>e", ":lua require'lir.float'.toggle()<CR>", opts)
