setlocal ts=2 sw=2 commentstring=#%s

nnoremap <leader>j :setlocal ts=2 sw=2 commentstring=#%s<CR>
nnoremap <leader>f :JuliaFormatterFormat<CR>
vnoremap <leader>f :JuliaFormatterFormat<CR>

autocmd BufWritePre *.jl :call StripTrailingWhitespaces()

" vim-slime
let g:slime_vimterminal_cmd = "julia"

hi Statement        cterm=NONE      ctermfg=9        ctermbg=NONE
