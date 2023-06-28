let g:gruvbox_transparent_bg=1
" Workaround for creating transparent bg
autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
autocmd SourcePost * highlight LineNr     ctermbg=NONE guibg=NONE
autocmd SourcePost * highlight SignColumn ctermbg=NONE guibg=NONE
