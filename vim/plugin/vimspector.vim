let g:vimspector_enable_mappings = 'HUMAN'

autocmd User VimspectorDebugEnded call system("mv ~/.vimspector.log " . $XDG_CACHE_HOME."/vim/")
