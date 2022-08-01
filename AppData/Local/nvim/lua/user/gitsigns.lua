local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

local hydra_status_ok, Hydra = pcall(require, "hydra")
if not hydra_status_ok then
  return
end

local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: toggle deleted   _b_: blame line
 _K_: prev hunk   _U_: undo last stage   _i_: diffThis         _B_: blame show full 
 _p_: preview     _S_: stage buffer      _I_: DiffPrevious     _/_: show base file
 _r_: reset hunk  _R_: reset buffer
]]

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

    Hydra({
      name = "Git",
      hint = hint,
      config = {
        buffer = bufnr,
        color = "pink",
        invoke_on_body = true,
        hint = {
          border = "rounded",
        },
        -- on_enter = function()
        --   vim.cmd("mkview")
        --   vim.cmd("silent! %foldopen!")
        --   vim.bo.modifiable = true
        --   gitsigns.toggle_signs(true)
        --   gitsigns.toggle_linehl(true)
        -- end,
        -- on_exit = function()
        --   local cursor_pos = vim.api.nvim_win_get_cursor(0)
        --   vim.cmd("loadview")
        --   vim.api.nvim_win_set_cursor(0, cursor_pos)
        --   vim.cmd("normal zv")
        --   gitsigns.toggle_signs(false)
        --   gitsigns.toggle_linehl(false)
        --   gitsigns.toggle_deleted(false)
        -- end,
      },
      mode = { "n", "x" },
      body = "<leader>g",
      heads = {
        {
          "J",
          function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gitsigns.next_hunk()
            end)
            return "<Ignore>"
          end,
          { expr = true, desc = "next hunk" },
        },
        {
          "K",
          function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gitsigns.prev_hunk()
            end)
            return "<Ignore>"
          end,
          { expr = true, desc = "prev hunk" },
        },
        { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
        { "r", ":Gitsigns reset_hunk<CR>", { desc = "reset hunk" } },
        { "U", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
        { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
        { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
        { "R", gitsigns.reset_buffer, { desc = "reset buffer" } },
        { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
        { "b", gitsigns.blame_line, { desc = "blame" } },
        { "i", gitsigns.diffthis, { desc = "diffThis" } },
        { "I", "<cmd>lua require'gitsigns'.diffthis('~')<CR>", { desc = "diffPrev" } },
        {
          "B",
          function()
            gitsigns.blame_line({ full = true })
          end,
          { desc = "blame show full" },
        },
        { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
        { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = false } },
        { "q", nil, { exit = true, nowait = true, desc = false } },
      },
    })
  end,
})
