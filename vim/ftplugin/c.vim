setlocal tabstop=8
setlocal shiftwidth=4
setlocal expandtab

setlocal fileformat=unix
setlocal formatoptions-=c formatoptions-=o formatoptions-=r

" Highlight the line limit
highlight OverLength cterm=underline
match OverLength /\%80v.*/
highlight BadWhitespace ctermbg=red
" Display tabs at the beginning of a line as bad.
match BadWhitespace /^\t\+/
" " Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/
