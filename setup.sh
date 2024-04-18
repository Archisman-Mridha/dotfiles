#!/bin/bash

# Create symlinks.
stow .

# Install zsh plugins.
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git \
  ~/.oh-my-zsh/custom/plugins/fzf-zsh-plugin

# Install fzf (version 0.50.0)
wget https://github.com/junegunn/fzf/releases/download/0.50.0/fzf-0.50.0-darwin_arm64.zip
mv fzf-0.50.0-darwin_arm64.zip ~/Downloads/fzf-0.50.0-darwin_arm64.zip
unzip ~/Downloads/fzf-0.50.0-darwin_arm64.zip
sudo mv fzf /usr/local/bin/
rm ~/Downloads/fzf-0.50.0-darwin_arm64.zip


# TODO: Complete script.
