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

    -- https://openbase.com/js/typescript-language-server/documentation
    -- Diagnostics code to be omitted when reporting diagnostics.
    -- See https://github.com/microsoft/TypeScript/blob/master/src/compiler/diagnosticMessages.json for a full list of valid codes.
    settings = {
      diagnostics = {
        ignoredCodes = { 80001 },
      },
    },
    -- init_options = {
    --   preferences = {
    --     disableSuggestions = true,
    --   },
    -- },
  },
})
