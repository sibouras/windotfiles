local options = {
  backup = false, -- creates a backup file
  -- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  -- conceallevel = 0,                        -- so that `` is visible in markdown files
  conceallevel = 3, -- conceal links in vimwiki
  fileencoding = "utf-8", -- the encoding written to a file
  fileformat = "unix",
  fileformats = "unix,dos",
  -- shellslash = true, -- breaks neo-tree and lir and maybe more
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 1, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 5, -- is one of my fav
  sidescrolloff = 10,
  foldlevelstart = 99,
  -- sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,globals",
  guifont = "JetbrainsMono Nerd Font:h16", -- the font used in graphical neovim applications
  -- guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:Cursor/lCursor", -- this makes changing Cursor highlight work
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.opt.iskeyword:append("-")
vim.opt.whichwrap:append("<,>,[,],h,l") -- let movement keys reach the previous line
vim.opt.shortmess:append("c") -- don't show the dumb matching stuff
vim.opt.path:append("**") -- find files recursively
-- vim.opt.concealcursor:append("nc")
vim.opt.jumpoptions:append("stack") -- browser-like jumplist behavior

-- vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
vim.cmd([[
  if exists("g:nvy") || exists("g:neovide")
    cd $home
  endif
  if exists("g:neovide")
    " let g:neovide_refresh_rate=140
  endif
  set grepprg=rg\ --vimgrep\ --smart-case " Replacing grep with rg
  set grepformat=%f:%l:%c:%m
  " https://gpanders.com/blog/whats-new-in-neovim-0-7/#filetypelua
  let g:do_filetype_lua = 1
  let g:did_load_filetypes = 0
  set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
]])

-- prettier folding
function _G.MyFoldText()
  return vim.fn.getline(vim.v.foldstart) .. " ... " .. vim.fn.getline(vim.v.foldend):gsub("^%s*", "")
end
vim.opt.foldtext = "v:lua.MyFoldText()"
vim.opt.fillchars:append({ fold = " " })

vim.g.python3_host_prog = "python3"

-- Disable builtin plugins
local disabled_built_ins = {
  -- "netrw", -- keep it for enter key to work in wiki.vim
  -- "netrwPlugin", -- keep it for gx to work
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
