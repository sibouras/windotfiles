local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")
-- local Path = require("plenary.path")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "shorten" },
    file_ignore_patterns = { ".git\\", "node_modules", "^.nvim" },
    sorting_strategy = "ascending",
    layout_config = {
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 100,
    },
    preview = {
      hide_on_startup = true, -- hide previewer when picker starts
    },
    mappings = {
      i = {
        ["`"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-h>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-a>"] = actions.toggle_all,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        ["<C-x>"] = actions.delete_buffer,
        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-BS>"] = { "<C-w>", type = "command", opts = { noremap = false } },
      },
      n = {
        ["`"] = actions.close,
        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["l"] = actions.select_default,
        ["<C-h>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-a>"] = actions.toggle_all,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["?"] = actions.which_key,
        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-x>"] = actions.delete_buffer,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      hidden = true, -- show hidden files
      path_display = { "smart" },
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      follow = true,
    },
    buffers = {
      initial_mode = "normal",
      -- ignore_current_buffer = true,
      sort_mru = true,
      previewer = false,
    },
    resume = {
      initial_mode = "normal",
    },
    -- order result by line number
    current_buffer_fuzzy_find = {
      tiebreak = function(current_entry, existing_entry)
        -- returning true means preferring current entry
        return current_entry.lnum < existing_entry.lnum
      end,
    },
    lsp_references = {
      theme = "dropdown",
      initial_mode = "normal",
      layout_strategy = "vertical",
      layout_config = { height = 0.95 },
      preview = {
        hide_on_startup = false, -- hide previewer when picker starts
      },
      path_display = { "tail" },
      show_line = true,
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        previewer = false,
      }),
    },
    -- workspaces = {
    --   -- keep insert mode after selection in the picker, default is false
    --   keep_insert = true,
    -- },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    recent_files = {
      only_cwd = true,
      show_current_file = true,
      -- path_display = function(_, path)
      --   local p = Path:new(path)
      --   return p.normalize(p)
      -- end,
    },
  },
})

telescope.load_extension("ui-select")
telescope.load_extension("workspaces")
telescope.load_extension("fzf")
telescope.load_extension("recent_files")
