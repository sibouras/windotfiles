return {
  {
    'rlane/pounce.nvim',
    keys = {
      { 's', '<cmd>Pounce<CR>', mode = { 'n', 'x' } },
      { 'S', '<cmd>PounceRepeat<CR>', mode = 'n' },
      { 'gs', '<cmd>Pounce<CR>', mode = 'o' },
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
