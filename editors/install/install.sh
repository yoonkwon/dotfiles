#!/usr/bin/env bash
THIS_DIR=$(cd "$(dirname "$0")"; pwd)

brew bundle --file="$THIS_DIR/Brewfile"


# Install Atom plugins
while IFS='' read -r PLUGIN || [[ -n "$PLUGIN" ]]; do
  if test ! -d "$HOME/.atom/packages/$PLUGIN"
  then
    apm install $PLUGIN
  fi
done < "$THIS_DIR/atom-packages.txt"

# Create some folders so that `.vimrc` works
mkdir -p $HOME/.vim/files/{backup,swap,undo,info}

# Install Vim plugins
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
if test ! -d "$VUNDLE_DIR"
then
  git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
else
  pushd "$VUNDLE_DIR" && git pull && popd
fi

# Workaround
## See https://github.com/VundleVim/Vundle.vim/issues/511
echo | echo | vim +PluginInstall +PluginUpdate +PluginClean +qall &>/dev/null
