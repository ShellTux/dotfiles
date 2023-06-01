let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1



" ###########
" Keybindings
" ###########
nnoremap <leader>n :NERDTreeFocus<CR>	" Opens (or reopens) the NERDTree if it is not currently visible
nnoremap <C-n> :NERDTree %<CR>		" Opens (or reopens) the NERDTree in file parent directory if it is not currently visible
nnoremap <C-t> :NERDTreeToggle %<CR>	" Opens or closes the NERDTree in file parent directory
nnoremap <C-f> :NERDTreeFind %<CR>
