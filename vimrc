" download vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'tipishev/vim-medic_chalk'

" Linting
Plug 'w0rp/ale'
let g:ale_fixers = { 'javascript': ['standard'], 'json': ['jq'], 'python': ['autopep8'], 'htmldjango': ['tidy'], 'sql': ['pgformatter'] }
let g:ale_linters = { 'javascript': ['standard'], 'python': ['flake8'], 'htmldjango': ['tidy'] }
let g:ale_disable_lsp = 1

nnoremap <silent> <F6> :ALEFix<CR>

" Nerd
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims=1
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Tim Pope <3
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

""" Language Specific

" JavaScript
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'

" JSON
Plug 'elzr/vim-json', { 'for': 'json' }

" Markdown
Plug 'jtratner/vim-flavored-markdown', { 'for': 'ghmarkdown' }

" Python
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }
Plug 'fisadev/vim-isort', { 'for': 'python' }
" Plug 'Valloric/YouCompleteMe' ", { 'do': './install.py' }
let g:vim_isort_map = '<C-i>'

" Erlang

"" Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.5.0 or vim >= 8.2.0750
nnoremap <expr><C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
nnoremap <expr><C-p> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-p>"
" inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
" inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Monkey-C
Plug 'tipishev/vim-monkey-c', { 'for': 'monkey-c' }

""" Interface tweaks

" search git project for word under cursor
nnoremap <F4> :Ggrep <C-r><C-w> -- './*' ':(exclude)migrations/*'<CR><CR>:wincmd j<CR>

" open quickfix upon grep
autocmd QuickFixCmdPost *grep* bot cwindow | setlocal wrap | nnoremap <buffer> <silent> q :cclose<CR>

Plug 'gcmt/taboo.vim'
let g:taboo_tab_format = " [%N]%f%m "
let g:taboo_renamed_tab_format = " [%N]%l%m "
Plug 'othree/html5.vim', { 'for': ['html', 'htmldjango'] }
Plug 'zef/vim-cycle'

Plug 'majutsushi/tagbar'
let g:tagbar_left = 1
nnoremap <silent> <F9> :TagbarToggle<CR>

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

colorscheme medic_chalk

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

nnoremap <silent> <F2> :w !setclip<CR>

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

" use xmllint for aligning XML
" :set equalprg=xmllint\ --format\ -

" Open Quickfix item in the previously-focused window
autocmd FileType qf nnoremap <cr> :exe 'wincmd p \| '.line('.').'cc'<cr>

" open Quickfix at the bottom, spanning all splits
au FileType qf wincmd J

set tags^=./.git/tags;
