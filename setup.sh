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
		echo "Installing $1"
		run_command "sudo apt-get install -y $1"
	fi
}

init
install_deb_if_not_present "gcc" "gcc"
install_deb_if_not_present "g++" "g++"
install_deb_if_not_present "python3-pip" "pip3"
