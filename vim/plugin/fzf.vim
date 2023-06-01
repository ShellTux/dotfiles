" ###############
" Custom commands
" ###############
command! -bang -nargs=? -complete=dir EFiles call fzf#vim#files("$HOME", <bang>0)
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)



" ###########
" Keybindings
" ###########
nnoremap <leader>pf :Files<CR>
nnoremap <C-p> :GitFiles<CR>			" Fzf, GitFiles (runs $FZF_DEFAULT_COMMAND if defined)
