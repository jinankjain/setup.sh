#!/bin/bash

function run_command() {
	$1
	if [ $? -ne 0 ]; then
		echo "Failed to run $1"
		exit 1
	fi
}

function init() {
	run_command "sudo apt-get update"
	run_command "sudo apt-get upgrade -y"
}

function install_deb_if_not_present() {
	if ! command -v "$2" &>/dev/null; then
		echo "=================== Installing $1 ======================="
		run_command "sudo apt-get install -y $1"
	fi
}

function install_cargo_if_not_present() {
	if ! command -v "$2" &>/dev/null; then
		echo "=================== Installing $1 ======================="
		run_command "cargo install $1"
	fi
}

function install_fzf_if_not_present() {
	if ! command -v "fzf" &>/dev/null; then
		echo "=================== Installing fzf ======================="
		run_command "git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf"
		run_command "$HOME/.fzf/install"
	fi
}

function install_neovim_if_not_present() {
	nvim_version="v0.6.1"
	nvim_release_url="https://github.com/neovim/neovim/releases/download/$nvim_version/nvim.appimage"
	if ! command -v "nvim" &>/dev/null; then
		echo "=================== Installing neovim ======================="
		wget "$nvim_release_url"
		chmod +x "nvim.appimage"
		run_command "sudo mv nvim.appimage /usr/bin/nvim"
		run_command "sudo cp /usr/bin/nvim /usr/bin/vim"
	fi

}

function install_pip_if_not_present() {
	if ! pip3 list | rg "$1" &>/dev/null; then
		echo "=================== Installing $1 ======================="
		run_command "pip3 install $1"
	fi
}

function install_nodejs_if_not_present() {
	nodejs_version="16.x"
	if ! command -v "node" &>/dev/null; then
		echo "=================== Installing nodejs ======================="
		curl -sL "https://deb.nodesource.com/setup_$nodejs_version" | sudo -E bash -
		run_command "sudo apt-get install -y nodejs"
	fi
}

function install_npm_if_not_present() {
	if ! npm list -g | rg "$1" &>/dev/null; then
		echo "=================== Installing $1 ======================="
		run_command "sudo npm install -g $1"
	fi
}

function install_nvim_config_if_not_present() {
	nvim_dir="$HOME/.config/nvim"
	if [ ! -d "$nvim_dir" ]; then
		run_command "mkdir -p $nvim_dir"
		run_command "git clone git@github.com:jinankjain/nvim-lua.git $nvim_dir"
	fi
}

function install_golang_if_not_present() {
	go_version="1.18"
	go_bin_url="https://go.dev/dl/go$go_version.linux-amd64.tar.gz"

	if ! command -v "go" &>/dev/null; then
		echo "=================== Installing golang ======================="
		curl -OL "$go_bin_url"
		run_command "sudo tar -C /usr/local -xvf go$go_version.linux-amd64.tar.gz"
		echo "export PATH=\"$PATH\":/usr/local/go/bin" >>"$HOME/.bashrc"
		rm "go$go_version.linux-amd64.tar.gz"
	fi
}

function install_gopkg_if_not_present() {
	if ! command -v "$2" &>/dev/null; then
		echo "=================== Installing $2 ======================="
		run_command "go install $1"
	fi
}

init

# Things to be installed via package manager
install_deb_if_not_present "gcc" "gcc"
install_deb_if_not_present "g++" "g++"
install_deb_if_not_present "git" "git"
install_deb_if_not_present "python3-pip" "pip3"
install_deb_if_not_present "tmux" "tmux"
install_deb_if_not_present "codespell" "codespell"
install_deb_if_not_present "codespell" "codespell"
install_deb_if_not_present "clang-12" "clang-12"
install_deb_if_not_present "clang-format-12" "clang-format-12"

# Things to be install via cargo
install_cargo_if_not_present "ripgrep" "rg"
install_cargo_if_not_present "fd-find" "fdfind"
install_cargo_if_not_present "zoxide" "zoxide"
install_cargo_if_not_present "zellij" "zellij"

install_fzf_if_not_present

install_neovim_if_not_present

install_pip_if_not_present "neovim"
install_pip_if_not_present "black"
install_pip_if_not_present "isort"

install_nodejs_if_not_present

install_npm_if_not_present "neovim"
install_npm_if_not_present "prettier"

install_nvim_config_if_not_present

install_golang_if_not_present
install_gopkg_if_not_present "mvdan.cc/sh/v3/cmd/shfmt@latest" "shfmt"
