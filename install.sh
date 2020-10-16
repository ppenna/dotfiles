#!/bin/bash

# Default parameters.
installAll=false;
installBash=false;
installCtags=false
installGit=false
installTmux=false
installVim=false
help=true

# Prints program usage.
function usage {
	utilName=`basename $0`
	echo "$utilName [--all] [--bash] [--ctags] [--git] [--tmux] [--vim]"
}

# Parse long options.
for arg in "$@"; do
	shift
	case "$arg" in
		"--all")   set -- "$@" "-a" ;;
		"--bash")  set -- "$@" "-b" ;;
		"--ctags") set -- "$@" "-c" ;;
		"--git")   set -- "$@" "-g" ;;
		"--tmux")  set -- "$@" "-t" ;;
		"--vim")   set -- "$@" "-v" ;;
		*)         set -- "$@" "$arg"
	esac
done

# Parse short options.
OPTIND=1
while getopts "abcgtv" opt
do
	case "$opt" in
		"a") help=false ; installAll=true   ;;
		"b") help=false ; installBash=true  ;;
		"c") help=false ; installCtags=true ;;
		"g") help=false ; installGit=true   ;;
		"t") help=false ; installTmux=true  ;;
		"v") help=false ; installVim=true   ;;
		"?") usage ; exit 1 ;;
	esac
done
shift $(expr $OPTIND - 1)

# Print help.
if [ $help == "true" ];
then
	usage
	exit 0
fi

# Install bash config.
if [ $installAll == "true" ] || [ $installBash == "true" ];
then
	cp -i bash/bashrc $HOME/.bashrc
	cp -i bash/bash_aliases $HOME/.bash_aliases
fi

# Install ctags config.
if [ $installAll == "true" ] || [ $installCtags == "true" ];
then
	cp -i ctags/ctags $HOME/.ctags
fi

# Install git config.
if [ $installAll == "true" ] || [ $installGit == "true" ];
then
	cp -i git/gitconfig /$HOME/.gitconfig
fi

# Install tmux config.
if [ $installAll == "true" ] || [ $installTmux == "true" ];
then
	cp -i tmux/tmux.conf $HOME/.tmux.conf
fi

# Install vim config.
if [ $installAll == "true" ] || [ $installVim == "true" ];
then
	cp -i vim/vimrc $HOME/.vimrc
	mkdir -p $HOME/.vim
	cp -r -i vim/ftplugin $HOME/.vim
	cp -r -i vim/spell $HOME/.vim
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
fi
