return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      normal = 'ms',
      normal_cur = 'mss',
      normal_line = 'mS',
      normal_cur_line = 'mSS',
      visual = 'ms',
      visual_line = false,
      delete = 'md',
      change = 'mr',
      change_line = false,
    },
    surrounds = {
      ['l'] = {
        add = function()
          local clipboard = vim.fn.getreg('+'):gsub('\n', '')
          return {
            { '[' },
            { '](' .. clipboard .. ')' },
          }
        end,
        find = '%b[]%b()',
        delete = '^(%[)().-(%]%b())()$',
        change = {
          target = '^()()%b[]%((.-)()%)$',
          replacement = function()
            local clipboard = vim.fn.getreg('+'):gsub('\n', '')
            return {
              { '' },
              { clipboard },
            }
          end,
        },
      },
      ['p'] = {
        add = { 'console.log(', ')' },
        find = 'console%.log%b()',
        delete = '^(console%.log%()().-(%))()$',
        change = {
          target = '^(console%.log%()().-(%))()$',
        },
      },
    },
  },
}
