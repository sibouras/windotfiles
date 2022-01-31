local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
  return
end

neoscroll.setup({
  hide_cursor = false, -- Hide cursor while scrolling
  easing_function = "quadratic", -- Default easing function
  -- Set any other options as needed
})
