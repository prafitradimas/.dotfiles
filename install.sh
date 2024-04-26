#! /usr/bin/bash

local ROOT=$(pwd)

neovim_setup() {
  sudo $pkg_install make cmake -y
  git clone https://github.com/neovim/neovim ~/neovim
  cd ~/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
  if which nvim > /dev/null 2>&1; then
    echo "neovim is installed." >> $log_file
  else
    echo "failed to install neovim." >> $log_file
  fi
}

ohmyzsh_setup() {
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
}

if which apt-get > /dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install nala
  if which nala > /dev/null 2>&1; then
    pkg_install="nala install "
    echo "nala is installed." >> $log_file
  else
    pkg_install="apt-get install "
  fi
elif [[ which dnf > /dev/null 2>&1 ]]; then
  pkg_install="dnf install "
elif [[ which pacman > /dev/null 2>&1 ]]; then
  pkg_install="pacman -S "
else
  echo "Installation failed: Package manager not found." >> $log_file
  print_log
  exit
fi

sudo $pkg_install zsh
if which zsh > /dev/null 2>&1; then
  sudo chsh -s $(which zsh)
  echo "zsh is installed." >> $log_file
else
  echo "failed to install zsh." >> $log_file
fi

sudo $pkg_install git
if which git > /dev/null 2>&1; then
  echo "git is installed." >> $log_file
  neovim_setup
else
  echo "failed to install git." >> $log_file
fi

sudo $pkg_install curl
if which curl > /dev/null 2>&1; then
  echo "curl is installed." >> $log_file
else
  echo "failed to install curl." >> $log_file
fi

sudo $pkg_install fzf
if which fzf > /dev/null 2>&1; then
  echo "fzf is installed." >> $log_file
else
  echo "failed to install fzf." >> $log_file
fi

sudo $pkg_install tmux
if which tmux > /dev/null 2>&1; then
  echo "tmux is installed." >> $log_file
else
  echo "failed to install tmux." >> $log_file
fi

print_log
