local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
  return
end

surround.setup({
  surrounds = {
    ["l"] = {
      add = function()
        local clipboard = vim.fn.getreg("+"):gsub("\n", "")
        return {
          { "[" },
          { "](" .. clipboard .. ")" },
        }
      end,
      find = "%b[]%b()",
      delete = "^(%[)().-(%]%b())()$",
      change = {
        target = "^()()%b[]%((.-)()%)$",
        replacement = function()
          local clipboard = vim.fn.getreg("+"):gsub("\n", "")
          return {
            { "" },
            { clipboard },
          }
        end,
      },
    },
    ["p"] = {
      add = { "console.log(", ")" },
      find = "console%.log%b()",
      delete = "^(console%.log%()().-(%))()$",
      change = {
        target = "^(console%.log%()().-(%))()$",
      },
    },
  },
})
