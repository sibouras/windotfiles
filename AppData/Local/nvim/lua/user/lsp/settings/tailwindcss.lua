-- https://github.com/ecosse3/nvim/blob/master/lua/lsp/servers/tailwindcss.lua
local M = {}

local on_attach = function(client, bufnr)
  if client.server_capabilities.colorProvider then
    require("user.lsp.utils.documentcolors").buf_attach(bufnr)
  end
end

local filetypes = {
  "html",
  "css",
  "javascriptreact",
  "typescriptreact",
  "vue",
  "svelte",
}

M.on_attach = on_attach
M.filetypes = filetypes

return M
