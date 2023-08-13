vim.cmd("autocmd BufWritePost *.service !systemctl --user daemon-reload")
vim.cmd("autocmd BufWritePost sxhkdrc !systemctl restart --user sxhkd")
vim.cmd("autocmd BufWritePost swhkdrc !systemctl restart --user hotkeys")
vim.cmd("autocmd BufWritePost config.def.h !doas make clean install")
