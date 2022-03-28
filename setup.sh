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
		echo "=================== Installing $1 ======================="
		run_command "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
		run_command "~/.fzf/install"
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
