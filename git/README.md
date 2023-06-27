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
cp              | cherry-pick
conflict        | diff --name-only --diff-filter=U
diff-copy       | !git diff-staged \| ([ "$XDG_SESSION_TYPE" = "x11" ] && xclip -selection clipboard \|\| wl-copy)
diff-staged     | diff --staged
diff-summary    | diff --stat
diff-word       | diff --word-diff --color-words
graph           | log --graph
project-summary | !which onefetch && onefetch
