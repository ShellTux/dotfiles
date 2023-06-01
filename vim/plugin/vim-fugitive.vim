" ###########
" Keybindings
" ###########
nnoremap <leader>ga :Git add %<CR>		" Add file to index of git repository
nnoremap <leader>gc :Git commit<CR>		" Make a commit. Record changes to the repository
nnoremap <leader>gC :Git checkout		" Switch branches or restore working tree files
nnoremap <leader>gd0 :tabnew %<CR> :Gvdiffsplit HEAD<CR>	" Show changes between last commit, but always split vertically
nnoremap <leader>gd1 :tabnew %<CR> :Gvdiffsplit HEAD~1<CR>	" Show changes between 2º last commit, but always split vertically
nnoremap <leader>gd2 :tabnew %<CR> :Gvdiffsplit HEAD~2<CR>	" Show changes between 3º last commit, but always split vertically
nnoremap <leader>gd3 :tabnew %<CR> :Gvdiffsplit HEAD~3<CR>	" Show changes between 4º last commit, but always split vertically
nnoremap <leader>gd4 :tabnew %<CR> :Gvdiffsplit HEAD~4<CR>	" Show changes between 5º last commit, but always split vertically
nnoremap <leader>gd5 :tabnew %<CR> :Gvdiffsplit HEAD~5<CR>	" Show changes between 6º last commit, but always split vertically
nnoremap <leader>gd6 :tabnew %<CR> :Gvdiffsplit HEAD~6<CR>	" Show changes between 7º last commit, but always split vertically
nnoremap <leader>gd7 :tabnew %<CR> :Gvdiffsplit HEAD~7<CR>	" Show changes between 8º last commit, but always split vertically
nnoremap <leader>gd8 :tabnew %<CR> :Gvdiffsplit HEAD~8<CR>	" Show changes between 9º last commit, but always split vertically
nnoremap <leader>gd9 :tabnew %<CR> :Gvdiffsplit HEAD~9<CR>	" Show changes between 10º last commit, but always split vertically
nnoremap <leader>gl :Git log<CR>		" Show commit logs
nnoremap <leader>gg :Git<CR>			" Show git
nnoremap <leader>gS :Git show<CR>		" Show various type of objects
nnoremap <leader>gs :Git stage %<CR>		" Add file contents to the staging area
nnoremap <leader>gp :Git push<CR>		" Update remote refs along with associated objects. Push commits to remote
