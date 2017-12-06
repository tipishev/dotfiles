if search('^\t', 'n', 150)
    setlocal shiftwidth=2
    setlocal noexpandtab
el 
    setlocal shiftwidth=1
    setlocal expandtab
en

highlight BadWhitespace ctermbg=red
match BadWhitespace /\s\+$\|\t/
