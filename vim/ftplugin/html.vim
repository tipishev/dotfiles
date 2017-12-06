setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab

highlight BadWhitespace ctermbg=red
" " Make trailing whitespace be flagged as bad.
"match BadWhitespace /\s\+$/
match BadWhitespace /\s\+$\|\t/

hi ColorColumn ctermbg=white
let &colorcolumn=join(range(100,999),",")
