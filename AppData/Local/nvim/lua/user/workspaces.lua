local status_ok, workspaces = pcall(require, "workspaces")
if not status_ok then
  return
end

workspaces.setup({
  hooks = {
    -- hooks run before change directory
    open_pre = {
      -- If recording, save current session state and stop recording
      "SessionsStop",
      -- delete all buffers (does not save changes)
      "silent %bdelete!",
    },

    -- hooks run after change directory
    -- open = "Telescope find_files",
    -- load any saved session from current directory
    open = function()
      require("sessions").load(nil, { silent = true })
    end,
  },
})
