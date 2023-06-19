[ $(tty | grep tty) ] && is_tty="yes" || is_tty="no"

[ -f "$XDG_CONFIG_HOME"/shell/aliasrc ] && source "$XDG_CONFIG_HOME"/shell/aliasrc
[ -f ${XDG_DATA_HOME:-$HOME/.local/share}/LS_COLORS ] && \
	eval $(dircolors -b ${XDG_DATA_HOME:-$HOME/.local/share}/LS_COLORS)

eval $(thefuck --alias)

fpath=(${XDG_CONFIG_HOME:-HOME/.config}/zsh/completions $fpath)

if command -v fastfetch &> /dev/null
then
	fastfetch
else
	neofetch
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh-histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep
# bindkey -v
bindkey -e
# End of lines configured by zsh-newuser-install


# The following lines were added by compinstall

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' glob 'NUMERIC == 2'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 3 not-numeric
zstyle ':completion:*' prompt '%e'
zstyle :compinstall filename "$HOME"'/.config/zsh/.zshrc'

autoload -Uz compinit
compinit -i -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# End of lines added by compinstall

# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'h' backward-char
# bindkey -M menuselect 'k' up-line-or-history
# bindkey -M menuselect 'l' forward-char
# bindkey -M menuselect 'j' down-line-or-history
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

fpath=("$XDG_CONFIG_HOME/zsh/prompt_themes" "$fpath[@]")
autoload -Uz promptinit
promptinit

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[ "$is_tty" = "yes" ] \
	&& source ~/.config/zsh/p10k.zsh \
	|| source ~/.config/zsh/p10k.terminal.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# git repository greeter
last_repository=
check_directory_for_new_repository() {
	current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
	
	[ "$current_repository" ] && [ "$current_repository" != "$last_repository" ] && \
		onefetch
	last_repository=$current_repository
}

cd() {
	builtin cd "$@"
	check_directory_for_new_repository
}

# optional, greet also when opening shell directly in repository directory
# adds time to startup
check_directory_for_new_repository
