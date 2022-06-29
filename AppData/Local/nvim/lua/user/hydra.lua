local status_ok, Hydra = pcall(require, "hydra")
if not status_ok then
  return
end

local splits_status_ok, splits = pcall(require, "smart-splits")
if not splits_status_ok then
  return
end

Hydra({
  name = "Side scroll",
  mode = "n",
  body = "z",
  config = {
    timeout = 250,
  },
  heads = {
    { "h", "5zh" },
    { "l", "5zl", { desc = "←/→" } },
    { "H", "zH" },
    { "L", "zL", { desc = "half screen ←/→" } },
  },
})

Hydra({
  name = "Split movements and resizing",
  mode = "n",
  body = "<C-w>",
  heads = {
    { "h", splits.move_cursor_left },
    { "j", splits.move_cursor_down },
    { "k", splits.move_cursor_up },
    { "l", splits.move_cursor_right },
    { "H", splits.resize_left },
    { "J", splits.resize_down },
    { "K", splits.resize_up },
    { "L", splits.resize_right },
  },
})
