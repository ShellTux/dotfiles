vim.cmd("autocmd BufWritePost sxhkdrc !systemctl restart --user sxhkd")
vim.cmd("autocmd BufWritePost config.def.h !doas make clean install")
