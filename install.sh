cp -i bash/bashrc $HOME/.bashrc
cp -i bash/bash_aliases $HOME/.bash_aliases
cp -i tmux/tmux.conf $HOME/.tmux.conf

# Vim
cp -i vimrc/vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
