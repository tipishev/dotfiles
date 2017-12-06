setlocal tabstop=8
setlocal shiftwidth=4
setlocal expandtab

setlocal fileformat=unix

autocmd FileType python noremap <buffer> <F6> :call Autopep8()<CR>
let g:autopep8_disable_show_diff=1
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace(); pass  # XXX breakpoint<esc>

hi ColorColumn ctermbg=white
let &colorcolumn=join(range(80,999),",")
highlight BadWhitespace ctermbg=red

call AddCycleGroup('python', ['True', 'False'])
call AddCycleGroup('python', ['red', 'green', 'blue', 'yellow', 'cyan', 'magenta'])
call AddCycleGroup('python', ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'])

let g:ycm_autoclose_preview_window_after_insertion = 1
