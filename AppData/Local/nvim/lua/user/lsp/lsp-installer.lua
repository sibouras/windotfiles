local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "cssls",
  -- "cssmodules_ls",
  -- "emmet_ls",
  "html",
  "tailwindcss",
  "jsonls",
  "sumneko_lua",
  "tsserver",
  "eslint",
}

local settings = {
  ensure_installed = servers,
}

lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require("user.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "tailwindcss" then
    opts = require("user.lsp.settings.tailwindcss")
  end

  if server == "cssls" then
    local tailwindcss_opts = require("user.lsp.settings.cssls")
    opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
  end

  -- if server == "tsserver" then
  --   local tsserver_opts = require("user.lsp.settings.tsserver")
  --   opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  -- end

  lspconfig[server].setup(opts)
end
