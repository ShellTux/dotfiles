#!/usr/bin/env zsh

_fzf_explore() {
	if command -v fd 2>/dev/null
	then
		fd --type=file
	else
		find . -type f
	fi | fzf \
			--preview='bat --color=always --style=numbers {}' \
			--bind='enter:execute(bat {})+clear-query' \
			--preview-window=right:70%

	zle redisplay
}

zle -N _fzf_explore

bindkey '^e' _fzf_explore
