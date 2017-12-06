"set equalprg=jscs\ --fix\ -
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

highlight BadWhitespace ctermbg=red

" Display tabs at the beginning of a line in Python mode as bad.
match BadWhitespace /^\t\+/
" " Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/

hi ColorColumn ctermbg=white
let &colorcolumn=join(range(100,999),",")

nnoremap <silent><F7> :JSHint<CR>
inoremap <silent><F7> <C-O>:JSHint<CR>
vnoremap <silent><F7> :JSHint<CR>

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

map <F9> :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
set conceallevel=0
