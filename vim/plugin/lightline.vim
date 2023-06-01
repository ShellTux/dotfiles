set laststatus=2
let g:lightline#component = {
		  \ 'mode': '%{lightline#mode()}',
		  \ 'absolutepath': '%F',
		  \ 'relativepath': '%f',
		  \ 'filename': '%t',
		  \ 'modified': '%M',
		  \ 'bufnum': '%n',
		  \ 'paste': '%{&paste?"PASTE":""}',
		  \ 'readonly': '%R',
		  \ 'charvalue': '%b',
		  \ 'charvaluehex': '%B',
		  \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
		  \ 'fileformat': '%{&ff}',
		  \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
		  \ 'percent': '%3p%%',
		  \ 'percentwin': '%P',
		  \ 'spell': '%{&spell?&spelllang:""}',
		  \ 'lineinfo': '%3l:%-2c',
		  \ 'line': '%l',
		  \ 'column': '%c',
		  \ 'close': '%999X X ',
		  \ 'winnr': '%{winnr()}' 
		  \ }
let g:lightline = {
		  \ 'colorscheme': 'onedark',
		  \ 'active': {
		  \   'left': [ [ 'mode', 'paste' ],
		  \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
		  \ },
		  \ 'component_function': {
		  \   'gitbranch': 'FugitiveHead',
		  \   'cocstatus': 'coc#status'
		  \ }
		  \ }
