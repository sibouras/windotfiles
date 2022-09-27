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
  auto_scroll = true,
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
  map("t", "<C-BS>", "<C-w>", opts)
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

vim.api.nvim_set_keymap("n", "<M-S-:>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })

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

vim.api.nvim_create_user_command("Lua", function()
  vim.cmd([[3TermExec cmd="lua %"]])
end, {})

local map = vim.keymap.set

map({ "n", "i", "t" }, "<M-1>", "<Cmd>1ToggleTerm direction=float<CR>")
map({ "n", "i", "t" }, "<M-2>", "<Cmd>2ToggleTerm size=60 direction=vertical<CR>")
map({ "n", "i", "t" }, "<M-3>", "<Cmd>3ToggleTerm size=15 direction=horizontal | set cmdheight=1<CR>")

-- Code Runner
local runners = { lua = "lua", javascript = "node", typescript = "tsx" }

local function run(n)
  local ftype = vim.bo.filetype
  local exec = runners[ftype]
  if exec ~= nil then
    if n ~= nil then
      vim.cmd(n .. [[TermExec cmd="]] .. exec .. [[ %"]])
    else
      require("toggleterm").exec(exec .. " " .. vim.fn.expand("%"))
    end
  end
end

map({ "n", "i" }, "<M-'>", run)
map("n", "<M-S-!>", function()
  run(1)
end)
map("n", "<M-S-@>", function()
  run(2)
end)
map("n", "<M-S-#>", function()
  run(3)
end)
