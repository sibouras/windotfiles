local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "✘" },
    { name = "DiagnosticSignWarn", text = "▲" },
    { name = "DiagnosticSignHint", text = "⚑" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- virtual_text = { prefix = "" },
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- local function lsp_highlight_document(client)
--   -- Set autocommands conditional on server_capabilities
--   if client.resolved_capabilities.document_highlight then
--     vim.api.nvim_exec(
--       [[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--       false
--     )
--   end
-- end

local opts = { noremap = true, silent = true }
local map = vim.keymap.set
map("n", "<leader>dg", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>dq", vim.diagnostic.setloclist, opts)
map("n", "<M-S-f>", vim.lsp.buf.formatting, opts)
map("v", "<M-S-f>", vim.lsp.buf.range_formatting, opts)
map("n", "<leader>li", "<cmd>LspInfo<cr>")
map("n", "<leader>lI", "<cmd>Mason<cr>")

-- toggle LSP diagnostics
vim.g.diagnostics_active = true
vim.keymap.set("n", "<leader>dt", function()
  vim.g.diagnostics_active = not vim.g.diagnostics_active
  if vim.g.diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end)

local function lsp_keymaps(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gd", vim.lsp.buf.definition, bufopts)
  map("n", "gD", vim.lsp.buf.declaration, bufopts)
  map("n", "gI", vim.lsp.buf.implementation, bufopts)
  map("n", "gR", vim.lsp.buf.references, bufopts)
  map({ "n", "i" }, "<M-m>", vim.lsp.buf.signature_help, bufopts)
  -- map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  map("n", "<leader>rn", ":lua require('user.essentials').lspRename()<CR>", bufopts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  map("v", "<leader>ca", vim.lsp.buf.range_code_action, bufopts)
  map("n", "<leader>lT", vim.lsp.buf.type_definition, bufopts)
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
  -- vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.formatting, {})
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  if client.name == "html" then
    client.resolved_capabilities.document_formatting = false
  end
  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
  lsp_keymaps(bufnr)
  -- lsp_highlight_document(client) -- use illuminate instead
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
