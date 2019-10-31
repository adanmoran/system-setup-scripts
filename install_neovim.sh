#!/bin/bash

# This script sets up a PPA and installs
# neovim.
function install_neovim() {

	# See if neovim is already installed:
	if hash nvim 2>/dev/null; then
	  echo "Neovim already installed"
	  return 0
	fi

	add-apt-repository -y ppa:neovim-ppa/unstable
	apt-get update
	apt-get install -y neovim

	# The following dependencies are required for
	# python support in neovim:
	apt-get install -y python-dev python-pip python3-dev python3-pip

	# This dependency is require for using the system clipboard:
	apt-get install -y xsel

	# Then install the python modules:
	pip2 install neovim                                                         \
		&& pip3 install neovim                                                   \
		&& update-alternatives --install /usr/bin/vi     vi     /usr/bin/nvim 60 \
		&& update-alternatives --install /usr/bin/vim    vim    /usr/bin/nvim 60 \
		&& update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60 \

}

# This function installs neovim-remote, which allows other
# programs to use neovim
#function install_nvr() {
#	if hash nvr 2>/dev/null; then
#		echo "NVR already installed"
#		return 0
#	fi
#	pip3 install neovim-remote
#}

install_neovim
#install_nvr

# vim: ts=3 sw=3 sts=0 noet :
