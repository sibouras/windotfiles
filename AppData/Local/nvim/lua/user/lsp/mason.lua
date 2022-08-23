local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      -- package_uninstalled = "✗",
    },
  },
})

local config_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not config_status_ok then
  return
end

-- https://github.com/williamboman/mason.nvim/discussions/92#discussioncomment-3173425
-- Extension to bridge mason.nvim with the lspconfig plugin
mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed.
  ensure_installed = {
    "lua-language-server",
  },
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

-- lspconfig server names: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- Default handler (optional)
    lspconfig[server_name].setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
    })
  end,

  -- Next, you can provide targeted overrides for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function()
  --   require("rust-tools").setup({})
  -- end,

  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      settings = {
        Lua = {
          -- Tells Lua that a global variable named vim exists to not have warnings when configuring neovim
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,

  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      commands = {
        OrganizeImports = {
          organize_imports,
          description = "Organize Imports",
        },
      },
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
    })
  end,

  ["tailwindcss"] = function()
    lspconfig.tailwindcss.setup({
      on_attach = function(client, bufnr)
        if client.server_capabilities.colorProvider then
          require("user.lsp.utils.documentcolors").buf_attach(bufnr)
        end
      end,
      capabilities = opts.capabilities,
      filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
    })
  end,

  ["cssls"] = function()
    lspconfig.cssls.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      settings = {
        css = {
          validate = true,
        },
      },
    })
  end,

  ["jsonls"] = function()
    lspconfig.jsonls.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      init_options = {
        provideFormatter = false,
      },
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
        },
      },
    })
  end,
})
