local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<M-;>]],
  on_open = function(term)
    vim.cmd("startinsert!")
  end,
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = "nu",
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  local map = vim.keymap.set

  map("t", "`", [[<C-\><C-n>]], opts)
  map("n", ";", ":close<CR>", opts)
  map("t", "<C-w><C-h>", [[<Cmd>wincmd h<CR>]], opts)
  map("t", "<C-w><C-j>", [[<Cmd>wincmd j<CR>]], opts)
  map("t", "<C-w><C-k>", [[<Cmd>wincmd k<CR>]], opts)
  map("t", "<C-w><C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<M-'>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
  node:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
  python:toggle()
end

vim.cmd([[
command! -count=1 Node lua require'toggleterm'.exec("node " .. vim.fn.expand('%'), <count>, 12)
]])

local map = vim.keymap.set

map("n", "<m-1>", "<cmd>1ToggleTerm direction=float<cr>")
map("t", "<m-1>", "<cmd>1ToggleTerm direction=float<cr>")
map("i", "<m-1>", "<cmd>1ToggleTerm direction=float<cr>")

map("n", "<m-2>", "<cmd>2ToggleTerm size=60 direction=vertical<cr>")
map("t", "<m-2>", "<cmd>2ToggleTerm size=60 direction=vertical<cr>")
map("i", "<m-2>", "<cmd>2ToggleTerm size=60 direction=vertical<cr>")

map("n", "<m-3>", "<cmd>3ToggleTerm size=10 direction=horizontal | set cmdheight=1<cr>")
map("t", "<m-3>", "<cmd>3ToggleTerm size=10 direction=horizontal | set cmdheight=1<cr>")
map("i", "<m-3>", "<cmd>3ToggleTerm size=10 direction=horizontal | set cmdheight=1<cr>")
