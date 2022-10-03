local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local types = require("cmp.types")
local context = require("cmp.config.context")

-- uncomment this if friendly snippets is installed
-- require("luasnip/loaders/from_vscode").lazy_load()

local select_opts = { behavior = cmp.SelectBehavior.Select }

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

vim.g.cmp_active = true

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  performance = {
    debounce = 80,
    throttle = 40,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
    ["<PageDown>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { "i", "c" }),
    -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- source: https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
    -- If the completion menu is visible, move to the next item. If the line is
    -- "empty", insert a Tab character. If the cursor is inside a word, trigger
    -- the completion menu.
    ["<Tab>"] = cmp.mapping(function(fallback)
      local col = vim.fn.col(".") - 1
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      -- elseif luasnip.jumpable(1) then
      --   luasnip.jump(1)
      elseif luasnip.expand_or_locally_jumpable(select_opts) then
        luasnip.expand_or_jump()
      elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        fallback()
      else
        cmp.complete()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  formatting = {
    expandable_indicator = true,
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- -- Kind icons
      -- vim_item.kind = kind_icons[vim_item.kind]
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- vim_item.menu = ({
      --   nvim_lsp = "[LSP]",
      --   nvim_lua = "[NVIM_LUA]",
      --   luasnip = "[Snippet]",
      --   buffer = "[Buffer]",
      --   path = "[Path]",
      -- })[entry.source.name]
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = "" .. strings[1] .. ""
      kind.menu = " (" .. strings[2] .. ")"
      return vim_item
    end,
  },
  sources = {
    {
      name = "nvim_lsp",
      entry_filter = function(entry, _)
        local kind = types.lsp.CompletionItemKind[entry:get_kind()]
        local in_capture = context.in_treesitter_capture
        if kind == "Snippet" then
          local name = vim.split(entry.source:get_debug_name(), ":")[2]
          if name == "emmet_ls" and (vim.bo.filetype == "javascriptreact" or vim.bo.filetype == "typescriptreact") then
            return in_capture("jsx_text")
          end
        end
        return true
      end,
    },
    -- { name = "nvim_lsp", max_item_count = 50 },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer", max_item_count = 10 },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
    -- completion = {
    --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    --   winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    -- },
  },
  experimental = {
    ghost_text = false,
  },
  -- view = {
  --   entries = "native",
  -- },
  -- disable completion in comments
  -- enabled = function()
  --   if
  --     require("cmp.config.context").in_treesitter_capture("comment") == true
  --     or require("cmp.config.context").in_syntax_group("Comment")
  --   then
  --     return false
  --   else
  --     return true
  --   end
  -- end,
  enabled = function()
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    if buftype == "prompt" then
      return false
    end
    return vim.g.cmp_active
  end,
})
