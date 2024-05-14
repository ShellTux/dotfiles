#!/bin/sh

set -eu

session_name="$(tmux display-message -p -F "#{session_name}")"
popup_name="popup-$session_name"
if echo "$session_name" | grep --quiet --extended-regex '^popup-.*$'
then
	tmux detach-client
else
	tmux \
		popup -d '#{pane_current_path}' \
		-xC -yC -w90% -h80% \
		-E "tmux attach -t '$popup_name' || tmux new -s '$popup_name'"
fi
