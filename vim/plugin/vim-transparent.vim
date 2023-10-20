let g:clear_background = 0
let g:transparent_groups = [
			\'Normal', 'Comment', 'Constant', 'Special', 
			\ 'Identifier', 'Statement', 'PreProc', 'Type', 
			\ 'Underlined', 'Todo', 'String', 'Function', 
			\ 'Conditional', 'Repeat', 'Operator', 'Structure',
			\ 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr',
			\ 'EndOfBuffer']

" Pmenu
let g:transparent_groups += ['Pmenu']

" coc.nvim
" let g:transparent_groups += ['NormalFloat', 'CocFloating']

augroup transparent
    autocmd VimEnter,ColorScheme * call MyTransparent()
augroup END

function! MyTransparent()
    " Customize the highlight groups for transparency in here.

    " CursorLine
    "hi CursorLine ctermfg=NONE ctermbg=239 guibg=NONE guibg=#4e4e4e

    " coc.nvim
    "hi CocMenuSel ctermbg=239 guibg=#4e4e4e
endfunction
