" download vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'elzr/vim-json', { 'for': 'json' }

" Linting
Plug 'w0rp/ale'
let g:ale_fixers = { 'javascript': ['standard']}

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mustache/vim-mustache-handlebars'

" Nerd
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims=1
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Tim Pope <3
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

Plug 'pgdouyon/vim-nim', { 'for': 'nim' }

Plug 'jtratner/vim-flavored-markdown', { 'for': 'ghmarkdown' }

" Python
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }

" search git project for word under cursor
nnoremap <F4> :Ggrep <C-r><C-w> -- './*' ':(exclude)migrations/*'<CR><CR>:wincmd j<CR>

" open quickfix upon grep
autocmd QuickFixCmdPost *grep* bot cwindow | setlocal wrap | nnoremap <buffer> <silent> q :cclose<CR>

Plug 'gcmt/taboo.vim'
let g:taboo_tab_format = " [%N]%f%m "
let g:taboo_renamed_tab_format = " [%N]%l%m "
Plug 'Valloric/YouCompleteMe' ", { 'do': './install.py' }
Plug 'othree/html5.vim', { 'for': ['html', 'htmldjango'] }
Plug 'zef/vim-cycle'
Plug 'majutsushi/tagbar'
let g:tagbar_left = 1
Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

"let g:UltiSnipsEditSplit = "horizontal"
"
let g:UltiSnipsExpandTrigger = '<C-@>' " terminals send C-@ when C-Space is pressed.
let g:UltiSnipsJumpForwardTrigger = '<C-%>' " some key I do not use at all
"let g:ultisnips_python_style="sphinx"

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
	call UltiSnips#JumpForwards()
	if g:ulti_jump_forwards_res == 0
	   return ""  " nothing more to do
	endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<CR>"

call plug#end()

" enable built-in macros, mostly to make % work on {, [, etc.
runtime macros/matchit.vim

" Python syntax highlight
let python_highlight_all=1

" look'n'feel
set updatetime=50
set noequalalways

set winminheight=0
set winminwidth=0

set splitright
set splitbelow

colorscheme desert
hi Search cterm=NONE ctermfg=black ctermbg=green

set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%{&fo}][%l,%v][%p%%]

set encoding=utf-8
set autoindent

set foldmethod=indent
set nofoldenable

" Mappings

"" Redraw syntax
noremap <F12> <Esc>:syntax sync fromstart<CR>
imap <F12> <ESC> <F12>

"" splits navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-left> :vertical resize -1<CR>
nnoremap <C-right> :vertical resize +1<CR>
nnoremap <C-down> :resize -1<CR>
nnoremap <C-up> :resize +1<CR>

"" make ctrl-arrows compatible with tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg

"" Line Numbers formatting
highlight LineNr term=bold ctermfg=DarkGrey guifg=DarkGrey

"" toggle paste mode
nnoremap <F8> <Esc>:set paste!<CR>
imap <F8> <ESC> <F8>

"" execute current file on F5 using shebang
function! RunShebang()
  if (match(getline(1), '^\#!') == 0)
    :!./%
  else
    echo "No shebang in this file."
  endif
endfunction

nnoremap <F5> :wa <BAR> :call RunShebang()<CR>
imap <F5> <ESC> <F5> 

" Ex mode tweaks
set history=10000 

" bash-like autocompletion
set wildmode=longest,list
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Allow selecting pasted text with `gp`
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" %%  expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" search options
set ignorecase
set smartcase
set incsearch

" no timeout for leader key
set notimeout
set ttimeout

" allow backspace-deleting a previous line 
set backspace=2

" TODO move to haskell filetype
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" disable arrow buttons to make life more miserable
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
