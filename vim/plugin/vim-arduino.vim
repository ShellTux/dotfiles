let g:arduino_home_dir = "$HOME/.arduino15"
let g:arduino_dir = '/usr/share/local/arduino'



" ###########
" Keybindings
" ###########
nnoremap <buffer> <leader>aa <cmd>ArduinoAttach<CR>	" Automatically attach to your board (see `arduino-cli board attach -h`). If no port is provided and there is more than one option, you will be prompted to select one.
nnoremap <buffer> <leader>am <cmd>ArduinoVerify<CR>	" Compile your project (`:make`)
nnoremap <buffer> <leader>au <cmd>ArduinoUpload<CR>	" Compile and upload your project
nnoremap <buffer> <leader>ad <cmd>ArduinoUploadAndSerial<CR>	" Compile and upload your project. If successful, open a connection to the serial port for debugging.
nnoremap <buffer> <leader>ab <cmd>ArduinoChooseBoard<CR>	" Set [board] to be the currently selected board. It should match the format
nnoremap <buffer> <leader>ap <cmd>ArduinoChooseProgrammer<CR>	" Set [programmer] to be the currently selected board. It should match the
