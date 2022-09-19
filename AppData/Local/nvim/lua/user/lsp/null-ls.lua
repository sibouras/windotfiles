local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
    -- formatting.prettierd.with({
    --   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "markdown" },
    -- }),
    formatting.prettierd,
    -- formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua.with({ extra_args = { "--indent-type=Spaces", "--indent-width=2" } }),
    code_actions.eslint_d.with({
      disabled_filetypes = { "typescript" },
      condition = function(utils)
        return utils.root_has_file({
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.json",
          "eslint.config.js",
        })
      end,
    }),
    diagnostics.eslint_d.with({
      disabled_filetypes = { "typescript" },
      condition = function(utils)
        return utils.root_has_file({
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.json",
          "eslint.config.js",
        })
      end,
    }),
  },
})
