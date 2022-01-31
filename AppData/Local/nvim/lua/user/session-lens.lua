local status_ok, session_lens = pcall(require, "session-lens")
if not status_ok then
  return
end

session_lens.setup({
  path_display = { "shorten" },
  theme_conf = { border = true },
  previewer = false,
})

-- local tele_status_ok, telescope = pcall(require, "telescope")
-- if not tele_status_ok then
-- 	return
-- end
--
-- telescope.load_extension("session-lens")
