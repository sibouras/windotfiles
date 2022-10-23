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
  -- pasting in term mode
  map("t", "<C-r>", [['<C-\><C-n>"' . nr2char(getchar()) . 'pi']], { expr = true, buffer = 0 })
  map("t", "<M-p>", [[<C-\><C-n>"+pi]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  count = 4,
  dir = "git_dir",
  on_open = function(term)
    vim.cmd("norm 0")
    vim.cmd("startinsert!")
    vim.keymap.set("n", "q", "<cmd>close<CR>", { silent = true, buffer = term.bufnr })
  end,
})

vim.keymap.set({ "n", "t" }, "<M-S-:>", function()
  lazygit:toggle()
end, { silent = true })

-- for wt,alacritty
vim.keymap.set({ "n", "t" }, "<M-:>", function()
  lazygit:toggle()
end, { silent = true })

vim.api.nvim_create_user_command("Lua", function()
  vim.cmd([[3TermExec cmd="lua %"]])
end, {})

local map = vim.keymap.set

map({ "n", "t" }, "<F1>", "<Cmd>1ToggleTerm direction=float<CR>")
map({ "n", "t" }, "<F2>", "<Cmd>2ToggleTerm size=60 direction=vertical<CR>")
map({ "n", "t" }, "<F3>", function()
  vim.cmd("3ToggleTerm size=13 direction=horizontal")
  vim.cmd("set cmdheight=1")
end)

-- Code Runner
local runners = { lua = "lua", javascript = "node", typescript = "tsx", go = "go run" }

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
map("n", "<S-F1>", function()
  run(1)
end)
map("n", "<S-F2>", function()
  run(2)
end)
map("n", "<S-F3>", function()
  run(3)
end)
