local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  return
end

harpoon.setup({
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },
  },
})

-- local tele_status_ok, telescope = pcall(require, "telescope")
-- if not tele_status_ok then
--   return
-- end
--
-- telescope.load_extension("harpoon")

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", opts)
map("n", "<M-f>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
-- map("n", "<leader>hc", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>")
for i = 1, 9 do
  map("n", i .. "<leader>", ":lua require('harpoon.ui').nav_file(" .. i .. ")<CR>", opts)
end
