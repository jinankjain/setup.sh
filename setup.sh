#!/bin/bash

function run_command () {
	$1
	if [ $? -ne 0 ]; then
		echo "Failed to run $1"
		exit 1
	fi
}

function init () {
	run_command "sudo apt-get update"
	run_command "sudo apt-get upgrade"
}

function install_deb_if_not_present() {
	if ! command -v "$2" &> /dev/null
	then
		echo "=================== Installing $1 ======================="
		run_command "sudo apt-get install -y $1"
	fi
}

function install_cargo_if_not_present() {
	if ! command -v "$2" &> /dev/null
	then
		echo "=================== Installing $1 ======================="
		run_command "cargo install $1"
	fi
}

function install_fzf_if_not_present() {
	if ! command -v "fzf" &> /dev/null
	then
		echo "=================== Installing fzf ======================="
		run_command "git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf"
		run_command "$HOME/.fzf/install"
	fi
}

function install_neovim_if_not_present() {
	nvim_version="v0.6.1"
	nvim_release_url="https://github.com/neovim/neovim/releases/download/$nvim_version/nvim.appimage"
	if ! command -v "nvim" &> /dev/null
	then
		echo "=================== Installing neovim ======================="
		wget "$nvim_release_url"
		chmod +x "nvim.appimage"
		run_command "sudo mv nvim.appimage /usr/bin/nvim"
		run_command "sudo cp /usr/bin/nvim /usr/bin/vim"
	fi

}

function install_pip_if_not_present() {
	if ! pip3 list | rg "$1" &> /dev/null
	then
		echo "=================== Installing $1 ======================="
		run_command "pip3 install $1"
	fi
}

init

# Things to be installed via package manager
install_deb_if_not_present "gcc" "gcc"
install_deb_if_not_present "g++" "g++"
install_deb_if_not_present "git" "git"
install_deb_if_not_present "python3-pip" "pip3"
install_deb_if_not_present "tmux" "tmux"

# Things to be install via cargo
install_cargo_if_not_present "ripgrep" "rg"
install_cargo_if_not_present "fd-find" "fdfind"
install_cargo_if_not_present "zoxide" "z"
install_cargo_if_not_present "zellij" "zellij"

install_fzf_if_not_present

install_neovim_if_not_present

install_pip_if_not_present "neovim" "neovim"
