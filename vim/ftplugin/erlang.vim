setlocal tabstop=8
setlocal shiftwidth=4
setlocal expandtab
setlocal equalprg=erlfmt\ - 

hi ColorColumn ctermbg=grey
let &colorcolumn=join(range(101,122),",")
highlight BadWhitespace ctermbg=red
