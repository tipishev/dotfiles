setlocal tabstop=8
setlocal shiftwidth=4
setlocal expandtab

hi ColorColumn ctermbg=white
let &colorcolumn=join(range(123,999),",")
highlight BadWhitespace ctermbg=red
