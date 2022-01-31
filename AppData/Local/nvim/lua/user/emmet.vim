let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key='z'

" Enable just for html/css/react
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascriptreact EmmetInstall
" let g:user_emmet_settings = {
" \  'javascript' : {
" \      'extends' : 'jsx',
" \  },
" \}
"

" remap conflicting mappings, still work in insert mode
nnoremap zm zm
nnoremap za za
