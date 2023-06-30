" Enable Mouse
set mouse=a

if exists(':GuiFont')
	" Use GuiFont! to ignore font errors
	GuiFont FiraCode Nerd Font:h20
endif

if exists(':GuiTabline')
	GuiTabline v:false
endif

if exists(':GuiPopupmenu')
	GuiPopupmenu v:false
endif

if exists(':GuiScrollBar')
	GuiScrollBar v:true
endif

if exists(':GuiRenderLigatures')
	GuiRenderLigatures v:true
endif

if exists(':GuiWindowOpacity')
	GuiWindowOpacity .8
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
