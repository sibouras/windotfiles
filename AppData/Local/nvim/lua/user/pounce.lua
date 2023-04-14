local status_ok, pounce = pcall(require, "pounce")
if not status_ok then
  return
end

pounce.setup({
  accept_keys = "JKLSDFAGHNUVRBYTMICEOXWPQZ",
  accept_best_key = "<enter>",
  multi_window = true,
  debug = false,
})

local map = vim.keymap.set

map({ "n", "x" }, "s", "<cmd>Pounce<CR>")
map("n", "S", "<cmd>PounceRepeat<CR>")
map("o", "gs", "<cmd>Pounce<CR>") -- s is used by nvim-surround
