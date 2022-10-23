local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
  return
end

neoscroll.setup({
  hide_cursor = false, -- Hide cursor while scrolling
  easing_function = "quadratic", -- Default easing function
  -- Set any other options as needed
  mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100", [['sine']] } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100", [['sine']] } }
-- Pass "nil" to disable the easing animation (constant scrolling speed)
-- t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
-- t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }
-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t["zt"] = { "zt", { "50" } }
t["zz"] = { "zz", { "50" } }
t["zb"] = { "zb", { "50" } }

require("neoscroll.config").set_mappings(t)
