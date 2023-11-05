local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Remap space as leader key
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' '

require('lazy').setup('plugins', {
  -- version = false, -- always use the latest git commit
  change_detection = { notify = false },
  -- checker = { enabled = true }, -- automatically check for plugin updates
  concurrency = jit.os:find('Windows') and 8 or nil,
  git = {
    log = { '--since=3 days ago' }, -- show commits from the last 3 days
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'rplugin',
        'zipPlugin',
        'tarPlugin',
        -- 'shada', -- for editing ShaDa files
        -- 'matchit', -- matches html tags
        'matchparen', -- replaced with sentiment.nvim
        'tohtml',
        'man',
        'spellfile',
      },
    },
  },
})

require('keymaps')
require('options')
require('autocmds')
