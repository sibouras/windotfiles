" replace entire content of file
function! functions#ReplaceFile()
  silent execute 'norm gg"_dGP'
endfunction

" tabs to spaces and spaces to tabs
function! functions#T2S ()
  set expandtab | %retab! | w
endfunction

function! functions#S2T ()
  set noexpandtab | %retab! | w
endfunction

" visual-at from: You don’t need more than one cursor in vim
function! functions#ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" yank text with line numbers and file name on top
function! functions#CompleteYank()
	redir @n | silent! :'<,'>number | redir END
	let filename=expand("%")
	let decoration=repeat('-', len(filename)+1)
	let @*=decoration . "\n" . filename . ':' . "\n" . decoration . "\n" . @n
endfunction

function! functions#RenameFile()
  let old_name = expand('%')
  let new_name = input('Rename: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    call delete(expand('#:p')) | bd # | redraw!
  endif
endfunction

function! functions#RemoveFile()
  let choice = confirm("Remove " . expand('%') . "?", "&Yes!\n&No", 1)
  if choice == 1
    call delete(expand('%:p')) | bwipeout!
  endif
endfunction

" Redirect the output of a Vim or external command into a scratch buffer
" source: https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! functions#Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let cmd = a:cmd =~' %'
      \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
      \ : matchstr(a:cmd, '^!\zs.*')
    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . " <<< $" . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif
  vnew
  let w:scratch = 1
  setlocal buftype=nofile filetype=Redir bufhidden=wipe nobuflisted noswapfile
  call setline(1, output)
endfunction
