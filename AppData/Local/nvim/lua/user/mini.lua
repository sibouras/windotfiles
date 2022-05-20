local status_ok, surround = pcall(require, "mini.surround")
if not status_ok then
  return
end

surround.setup({
  custom_surroundings = {
    -- Use `(` to insert with spaces, `)` will still add without them
    [")"] = { output = { left = "( ", right = " )" } },
  },
  mappings = {
    add = "sa", -- Add surrounding
    delete = "sd", -- Delete surrounding
    find = "st", -- Find surrounding (to the right)
    find_left = "sT", -- Find surrounding (to the left)
    highlight = "sh", -- Highlight surrounding
    replace = "sr", -- Replace surrounding
    update_n_lines = "sn", -- Update `n_lines`
  },
  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 200,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
  search_method = "cover_or_next",
})
