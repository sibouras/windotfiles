local status_ok, sessions = pcall(require, "sessions")
if not status_ok then
  return
end

sessions.setup({
  session_filepath = vim.fn.stdpath("data") .. "/sessions",
  absolute = true,
})
