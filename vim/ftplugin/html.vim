""""""""""""""""""""""""""""""""""""""""""""""
"  General
""""""""""""""""""""""""""""""""""""""""""""""
setlocal foldmethod=indent
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

autocmd BufWritePre *.html :call StripTrailingWhitespaces()
