# [Git](https://git-scm.com/)

![Git](https://git-scm.com/images/logo@2x.png)

Git is a free and open source distributed version control system designed
to handle everything from small to very large projects with speed and efficiency.

## Init

- defaultBranch = `main`

## Core

- excludesFile = `~/.config/git/ignore_global`

This file `~/.config/git/ignore_global`
contain a list of directories and files to ignore.

## Alias

Alias           | Command
---             | ---
`branch-delete` | `branch --delete`
`br` | `branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate`
`ci` | `commit`
`co` | `checkout`
`conflict` | `diff --name-only --diff-filter=U`
`cp` | `cherry-pick`
`diff-copy` | `!git diff-staged \| ([ "$XDG_SESSION_TYPE" = "x11" ] && xclip -selection clipboard \|\| wl-copy)`
`diff-staged` | `diff --staged`
`diff-summary` | `diff --stat`
`diff-word` | `diff --word-diff --color-words`
`forget` | `update-index --assume-unchanged`
`graph` | `log --graph`
`last` | `"!git -c core.pager= log -1 HEAD"`
`lg` | `"!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30"`
`open` | `visit`
`project-summary` | `!which onefetch && onefetch`
`put` | `push --set-upstream origin`
`serve` | `daemon --verbose --export-all --base-path=.git --reuseaddr --strict-paths .git/`
`showconfig` | `config --list`
`s` | `"status --short"`
`st` | `status`
`touch` | `"!touch $@ && git add $@"`
`unstage` | `reset HEAD --`
