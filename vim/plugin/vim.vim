function! ToggleLineNumbers()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
    set nonumber
  endif
endfunction

function! AlignByDelimiter(start, end)
	let separator = input('Align by: ', '=')
	execute ":silent" . a:start . "," . a:end "!column --table --separator=" . separator . " --output-separator=="
endfunction



command! ToggleLineNumbers call ToggleLineNumbers()
command! -range AlignBy call AlignByDelimiter(<line1>, <line2>)
command! -nargs=? -complete=file ToHex silent exec "%!xxd " . shellescape(expand("<args>" != "" ? "<args>" : "%:p")) | setlocal filetype=hex buftype=nofile bufhidden=hide noswapfile ro
