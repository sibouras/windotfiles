return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  opts = {
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
