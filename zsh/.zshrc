[ $(tty | grep tty) ] && is_tty="yes" || is_tty="no"

# Enable Powerlevel10k instant prompt.
# Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
p10k_prompt="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
[ -r "$p10k_prompt" ] && source "$p10k_prompt"

for file in \
	/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
	/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
do
	source "$file"
done

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[ "$is_tty" = "yes" ] \
	&& source ~/.config/zsh/p10k.zsh \
	|| source ~/.config/zsh/p10k.terminal.zsh

aliasrc="${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "$aliasrc" ] && source "$aliasrc"

LS_COLORS="${XDG_DATA_HOME:-$HOME/.local/share}/LS_COLORS"
[ -f "$LS_COLORS" ] && eval $(dircolors -b "$LS_COLORS")

# Created by newuser for 5.9
# Lines configured by zsh-newuser-install
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt autocd extendedglob notify
unsetopt beep
# bindkey -v
bindkey -e
# End of lines configured by zsh-newuser-install

# Completions
fpath=("${XDG_CONFIG_HOME:-$HOME/.config}/zsh/completions" $fpath)
[ -f "$ZDOTDIR"/zsh-comp ] && source "$ZDOTDIR"/zsh-comp
autoload -Uz compinit
compinit -i -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump-"$ZSH_VERSION"

# Themes
fpath=("${XDG_CONFIG_HOME:-$HOME/.config}/zsh/prompt_themes" "$fpath[@]")
autoload -Uz promptinit
promptinit

[ -f "$ZDOTDIR"/zsh-keybindings ] && source "$ZDOTDIR"/zsh-keybindings

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

if command -v fastfetch &> /dev/null
then
	fastfetch
elif command -v neofetch &> /dev/null
then
	neofetch
fi

[ -f "$ZDOTDIR"/zsh-onefetch ] && source "$ZDOTDIR"/zsh-onefetch
