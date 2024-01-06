# My Dotfiles

These are my personal configuration files for various applications
that I use on a daily basis.
This repository serves as a way to easily sync and backup my configurations
across different machines.

## Installation

To install these dotfiles on a new machine, simply clone this repository into your home directory:

```sh
git clone https://github.com/ShellTux/dotfiles ~/.config
```

Then run make to install symbolic links to `.bashrc`, `.bash_profile`,
`.xinitrc`, `.Xresources` on the home directory, and install the files under the etc folder.

```sh
cd ~/.config
make
```


## Usage

Once installed, any changes you make to the configuration files in your home
directory will be reflected in the corresponding files in this repository.
Similarly, any changes you make to the files in this repository
will be reflected in your home directory.

Some programs depend on my [shell scripts](https://github.com/ShellTux/shell-scripts).

```sh
git clone https://github.com/ShellTux/shell-scripts ~/.local/bin
```

Feel free to fork this repository or steal any configuration and customize it to your liking.
