[ $(tty | grep tty) ] && is_tty=true || is_tty=false
# HACK: Check if running a tty, even with tmux
[ -n "$DISPLAY" ] && is_tty=false || is_tty=true

[ ! "$ASCIINEMA_REC" = 1 ] && neofetch

if  command -v zellij &>/dev/null && [ -z "$TMUX" ]
then
	eval "$(zellij setup --generate-auto-start zsh)"
fi

# Enable Powerlevel10k instant prompt.
# Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
p10k_prompt="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
[ -r "$p10k_prompt" ] && source "$p10k_prompt"

for file in \
	/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
	/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
do
	[ -r "$file" ] && source "$file"
done

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
$is_tty \
	&& source ~/.config/zsh/p10k_tty.zsh \
	|| source ~/.config/zsh/p10k.zsh

LS_COLORS="${XDG_DATA_HOME:-$HOME/.local/share}/LS_COLORS"
[ -f "$LS_COLORS" ] && eval $(dircolors -b "$LS_COLORS")

# Created by newuser for 5.9
# Lines configured by zsh-newuser-install
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt autocd extendedglob notify
setopt hist_ignore_all_dups hist_find_no_dups
unsetopt beep
# bindkey -v
bindkey -e
# End of lines configured by zsh-newuser-install

if [ ! -f "$HISTFILE" ]
then
	mkdir --parents "$(dirname "$HISTFILE")"
	touch "$HISTFILE"
fi

# Completions
fpath=("${XDG_CONFIG_HOME:-$HOME/.config}/zsh/completions" $fpath)
[ -f "$ZDOTDIR"/zsh-comp ] && source "$ZDOTDIR"/zsh-comp
autoload -Uz compinit
compinit -i -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump-"$ZSH_VERSION"

# Themes
fpath=("${XDG_CONFIG_HOME:-$HOME/.config}/zsh/prompt_themes" "$fpath[@]")
autoload -Uz promptinit
promptinit

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

for file in \
	/usr/share/fzf/completion.zsh \
	/usr/share/fzf/key-bindings.zsh \
	/usr/share/wikiman/widgets/widget.zsh \
	/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	"$ZDOTDIR"/zsh-keybindings \
	"${XDG_CONFIG_HOME:-$HOME/.config}/zsh/completions/fzf/kubectl" \
	"${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
do
	[ -f "$file" ] && source "$file"
done
