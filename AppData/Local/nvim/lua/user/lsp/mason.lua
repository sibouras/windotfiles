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
-- this slows down startuptime
-- mason_lspconfig.setup({
--   -- A list of servers to automatically install if they're not already installed.
--   ensure_installed = {
--     "lua-language-server",
--   },
-- })

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
      single_file_support = false,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,

  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      -- autostart = false,
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
      -- disable lsp in node_modules
      root_dir = function(fname)
        if string.find(fname, "node_modules/") then
          return
        end
        local root_files = { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
        return lspconfig.util.root_pattern(unpack(root_files))(fname)
      end,
    })
  end,

  ["tailwindcss"] = function()
    lspconfig.tailwindcss.setup({
      on_attach = function(client, bufnr)
        if client.server_capabilities.colorProvider then
          -- require("user.lsp.utils.documentcolors").buf_attach(bufnr)
          require("document-color").buf_attach(bufnr)
        end
        -- client.server_capabilities.hoverProvider = false
        client.server_capabilities.completionProvider.triggerCharacters = {
          '"',
          "'",
          "`",
          ".",
          "(",
          "[",
          "!",
          "/",
          ":",
        }
      end,
      capabilities = opts.capabilities,
      -- flags = {
      --   debounce_text_changes = 500,
      -- },
      filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
      root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
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

  ["emmet_ls"] = function()
    lspconfig.emmet_ls.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
      -- filetypes = { "html", "css", "sass", "scss", "less" },
    })
  end,

  ["marksman"] = function()
    lspconfig.marksman.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      cmd = { "marksman.cmd", "server" },
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
          validate = { enable = true },
        },
      },
    })
  end,

  ["eslint"] = function()
    lspconfig.eslint.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      root_dir = lspconfig.util.root_pattern(
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        "eslint.config.js"
      ),
    })
  end,

  ["gopls"] = function()
    lspconfig.gopls.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      cmd = { "gopls.cmd" },
    })
  end,
})
