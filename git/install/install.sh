#!/usr/bin/env bash
THIS_DIR=$(cd "$(dirname "$0")"; pwd)

LANG="en_EN.UTF-8" brew bundle --file="$THIS_DIR/Brewfile"

# Install git-lfs
git lfs install

# Install git-wip
GIT_WIP_DIR="${HOME}/bin/git-wip"

if [ ! -d ${GIT_WIP_DIR} ]
then
  git clone git://github.com/bartman/git-wip.git "${GIT_WIP_DIR}"
fi

if [ ! -L /usr/local/bin/git-wip ]
then
  ln -s "${GIT_WIP_DIR}/git-wip" /usr/local/bin/git-wip
fi

# See https://github.com/so-fancy/diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

# See https://github.com/sjurba/rebase-editor?ref=stackshare
npm list -g rebase-editor && npm update --silent -g rebase-editor || npm install --silent -g rebase-editor
git config --global sequence.editor rebase-editor

# See https://github.com/joshdick/git-fuzzy
npm list -g git-fuzzy && npm update --silent -g git-fuzzy || npm install --silent -g git-fuzzy
