local configs = require("nvim-treesitter.configs")

require("nvim-treesitter.install").compilers = { "clang", "gcc" }

-- require("hlargs").setup({ color = "#e0af68" })

-- use html parser in ejs files
vim.treesitter.language.register("html", "ejs")

configs.setup({
  ensure_installed = {
    -- "html",
    -- "css",
    -- "javascript",
    -- "tsx",
    -- "typescript",
    -- "markdown",
    -- "markdown_inline",
  },
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  -- ignore_install = { "tlaplus" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "" }, -- list of language that will be disabled
    -- Or use a function for more flexibility
    disable = function(lang, buf)
      -- filetypes that will be disabled
      -- local filetype_exclude = { "help" }
      -- if vim.tbl_contains(filetype_exclude, vim.bo.filetype) then
      --   return true
      -- end

      -- disable for lines > 10000
      -- if vim.api.nvim_buf_line_count(buf) > 10000 then
      --   return true
      -- end

      -- disable slow treesitter highlight for large files
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "go", -- set to `false` to disable one of the mappings
      node_incremental = "<C-o>",
      node_decremental = "<M-C-S-F6>", -- <C-i>
      scope_incremental = ".",
    },
  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
    enable = false,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ae"] = "@call.outer",
        ["ie"] = "@call.inner",
        ["in"] = "@number.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["]r"] = "@parameter.inner",
      },
      swap_previous = {
        ["[r"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@comment.outer",
        ["]a"] = "@parameter.inner",
        ["]e"] = "@call.outer",
        ["]b"] = "@block.outer",
        ["]n"] = "@number.inner",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@comment.outer",
        ["]A"] = "@parameter.inner",
        ["]E"] = "@call.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@comment.outer",
        ["[a"] = "@parameter.inner",
        ["[e"] = "@call.outer",
        ["[b"] = "@block.inner",
        ["[n"] = "@number.inner",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@comment.outer",
        ["[A"] = "@parameter.inner",
        ["[E"] = "@call.outer",
        ["[B"] = "@block.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        ["]v"] = "@conditional.outer",
      },
      goto_previous = {
        ["[v"] = "@conditional.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = "rounded",
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
})

-- folding(slow for large files)
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
local map = vim.keymap.set
-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- This repeats the last query with always previous direction and to the start of the range.
map({ "n", "x", "o" }, "<home>", function()
  ts_repeat_move.repeat_last_move({ forward = false, start = true })
end)
-- This repeats the last query with always next direction and to the end of the range.
map({ "n", "x", "o" }, "<end>", function()
  ts_repeat_move.repeat_last_move({ forward = true, start = false })
end)

-- LSP diagnostics
local diagnostic_goto_next_repeat, diagnostic_goto_prev_repeat =
  ts_repeat_move.make_repeatable_move_pair(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
map({ "n", "x", "o" }, "[d", diagnostic_goto_prev_repeat)
map({ "n", "x", "o" }, "]d", diagnostic_goto_next_repeat)

local status_ok, gs = pcall(require, "gitsigns")
if not status_ok then
  return
end
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

vim.keymap.set({ "n", "x", "o" }, "]g", next_hunk_repeat)
vim.keymap.set({ "n", "x", "o" }, "[g", prev_hunk_repeat)
