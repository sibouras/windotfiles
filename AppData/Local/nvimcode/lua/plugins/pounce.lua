return {
  {
    'rlane/pounce.nvim',
    keys = {
      { 's', '<Cmd>Pounce<CR>', mode = { 'n', 'x', 'o' } },
      { 'S', '<Cmd>PounceRepeat<CR>', mode = 'n' },
      { 'gs', '<Cmd>PounceExpand <cword><CR>', mode = 'n', desc = 'Pounce with the current word' },
      { 'gs', 'y<Cmd>PounceReg "<CR>', mode = 'x', desc = 'Pounce using the selection as the input' },
    },
    opts = {
      accept_keys = 'JKLSDFAGHNUVRBYTMICEOXWPQZ',
      accept_best_key = '<enter>',
      multi_window = true,
      debug = false,
    },
    config = function(_, opts)
      require('pounce').setup(opts)
      vim.api.nvim_set_hl(0, 'PounceAccept', { bold = true, fg = '#ffffff', bg = '#3F00FF' })
      vim.api.nvim_set_hl(0, 'PounceAcceptBest', { bold = true, fg = '#ffffff', bg = '#FF2400' })
    end,
  },
}
