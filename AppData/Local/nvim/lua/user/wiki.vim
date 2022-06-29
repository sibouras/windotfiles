let g:wiki_root = '~/code/react/docuwiki/docs'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'

let g:wiki_export = {
  \ 'args' : '--highlight-style=pygments',
  \ 'from_format' : 'markdown',
  \ 'ext' : 'html',
  \ 'link_ext_replace': v:true,
  \ 'view' : v:false,
  \ 'output': fnamemodify(tempname(), ':h'),
  \}

let g:wiki_mappings_global = {
  \ '<plug>(wiki-journal-index)': '<leader>wi',
  \ }

let g:wiki_mappings_local = {
  \ '<plug>(wiki-journal-prev)' : '[w',
  \ '<plug>(wiki-journal-next)' : ']w',
  \}

" " let g:vim_markdown_folding_disabled = 1
" " let g:vim_markdown_autowrite = 0
" let g:vim_markdown_folding_style_pythonic = 1
" let g:vim_markdown_override_foldtext = 0
"
" " disable header folding
" let g:vim_markdown_folding_disabled = 1
"
" " do not use conceal feature, the implementation is not so good
" let g:vim_markdown_conceal = 0

" source: https://old.reddit.com/r/neovim/comments/sdoljj/made_a_super_small_function_to_create_a_note/
function! Spawn_note_window() abort
  let path = "~/wiki/journal/"
  let file_name = path.strftime("%Y-%m-%d.md")
  " Empty buffer
  let buf = nvim_create_buf(v:false, v:true)
  " Get current UI
  let ui = nvim_list_uis()[0]
  " Dimension
  let width = (ui.width/7*4)
  let height = (ui.height/7*4)
  " Options for new window
  let opts = {'relative': 'editor',
              \ 'width': width,
              \ 'height': height,
              \ 'col': (ui.width - width)/7*4,
              \ 'row': (ui.height - height)/7*4,
              \ 'anchor': 'NW',
              \ 'style': 'minimal',
              \ 'border': 'single',
              \ }
  " Spawn window
  let win = nvim_open_win(buf, 1, opts)
  " Now we can actually open or create the note for the day?
  if filereadable(expand(file_name))
    execute "e ".fnameescape(file_name)
    execute "norm G"
    " execute "norm zz"
    " execute "startinsert"
  else
    execute "e ".fnameescape(file_name)
    execute "norm Gi## Notes for ".strftime("%Y-%m-%d")
    execute "norm Go\n"
    execute "norm Gi-  " 
    execute "norm zz"
    " execute "startinsert"
  endif
endfunction

nmap <silent> <leader>wj :call Spawn_note_window()<CR>
