local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
  return
end

typescript.setup({
  -- disable_commands = false, -- prevent the plugin from creating Vim commands
  -- debug = false, -- enable debug logging for commands
  server = { -- pass options to lspconfig's setup method
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  },
})
