local status_ok, sessions = pcall(require, "sessions")
if not status_ok then
  return
end

sessions.setup({
  session_filepath = vim.fn.stdpath("data") .. "/sessions",
  absolute = true,
})

local map = vim.keymap.set

map("n", "<leader>sl", ":SessionsLoad<CR>", { silent = true })
map("n", "<leader>ss", ":SessionsSave<CR>", { silent = true })
map("n", "<leader>sd", ":SessionsStop<CR>", { silent = true })
