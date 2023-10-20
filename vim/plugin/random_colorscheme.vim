if (has('termguicolors') && &termguicolors) || has('gui_running') || &t_Co == 256
	let g:random_disabled = 0
	let g:default_theme = 'onedark'
else
	let g:random_disabled = 1
	let g:default_theme = 'default'
endif
let g:random_scheme = 1
let g:available_colorschemes = [
      \ 'dracula',
      \ 'gruvbox',
      \ 'gruvbox-material',
      \ 'molokai',
      \ 'nightfly',
      \ 'onedark',
      \ 'retrobox',
      \ 'tokyonight'
      \]
