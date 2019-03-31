#!/bin/bash

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install 
# npm

# hub
# shfmt
# kubectx
# install base packages

sudo apt-get install golang-go emacs fonts-powerline curl
sudo apt-get install 
mkdir -p ~/go/bin

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

#curl -fL https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip

# install golang debugger
go get -u github.com/derekparker/delve/cmd/dlv


# install rust
curl https://sh.rustup.rs -sSf | sh
# ios
rustup target add aarch64-apple-ios armv7-apple-ios armv7s-apple-ios x86_64-apple-ios i386-apple-ios
# android
rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android
# wasm
rustup target add wasm32-unknown-unknown


# install and setup antibody
# brew install getantibody/tap/antibody
# cp .zsh_plugins.txt ~/.zsh_plugins.txt
# antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# set default shell to zsh
zsh --version
chsh -s $(which zsh)

# merge our zshrc contents if one already exists, otherwise just copy it over
if [ -f ~/.zshrc ]; then
    echo "=== Merging .zshrc Files (MIGHT REQUIRE MANUAL CLEANUP!)==="
    cat .zshrc | cat - ~/.zshrc > temp && rm ~/.zshrc && mv temp ~/.zshrc
else
    echo "=== Copying .zshrc File ==="
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi

# git settings/aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.com commit
git config --global alias.st status

# Copy vs code settings
cp vscode/* $HOME/.config/Code/User/

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh 
