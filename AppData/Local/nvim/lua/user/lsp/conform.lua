local status_ok, conform = pcall(require, "conform")
if not status_ok then
	return
end

conform.setup({
	notify_on_error = false,
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
	},
	format_on_save = function()
		if vim.g.disable_autoformat then
			return
		end
		return {
			timeout_ms = 500,
			lsp_fallback = true,
		}
	end,
})

-- Add commands to toggle formatting.
vim.api.nvim_create_user_command("FormatDisable", function()
	vim.g.disable_autoformat = true
end, { desc = "Disable format on save", nargs = 0 })
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.g.disable_autoformat = false
end, { desc = "Enable format on save", nargs = 0 })
