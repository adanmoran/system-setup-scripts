#!/bin/bash

# This script installs latex tools that are essential for 
# both compiling and displaying latex nicely

function install_latex() {
	# Install latex, zathura, and the tools for building latex
	apt-get install -y texlive-full \
		zathura \
		xdotool \
		latexmk \
		biber
}

function install_pplatex() {

	if hash ppdflatex 2>/dev/null; then
		"pplatex is already installed."
		return 0
	fi

	# Specify which version of pplatex to install
	local -r TAG=$1

	# Build dependencies
	apt-get install -y libpcre3-dev

	# Specify where we will install stuff
	local -r INSTALL_PREFIX=/usr/local

	# Now pull the repo
	if [[ ! -d "${INSTALL_PREFIX}/src/ppdflatex" ]]; then
		mkdir -p "${INSTALL_PREFIX}/src/"
		cd "${INSTALL_PREFIX}/src"
		git clone https://www.github.com/stefanhepp/pplatex
	fi

	# Now specify the source directory
	local -r PPLATEX_SRC="${INSTALL_PREFIX}/src/pplatex"

	# Update the repo and checkout the correct tag
	cd "${PPLATEX_SRC}"
	git pull
	git checkout ${TAG}

	# Now build
	# pplatex is built to SRC/build/src/pplatex
	# At the end we create a symbolic link to pplatex in our bin
	cd ${PPLATEX_SRC}/build \
		&& cmake ${PPLATEX_SRC} \
		&& make \
		&& ln -s ${PPLATEX_SRC}/build/src/pplatex /usr/bin/ppdflatex \
	   && ln -s ${PPLATEX_SRC}/build/src/pplatex /usr/bin/ppluatex
}

function update_biblatex_ieee() {
	# Switch to the texmf folder
	mkdir -p ~/texmf
	cd ~/texmf

	if [[ -d "~/texmf/biblatex-ieee" ]]; then
		echo "There is already a local version of biblatex-ieee."
		return 0
	fi

	# Download the latest version of biblatex-ieee
	wget http://mirrors.ctan.org/macros/latex/contrib/biblatex-contrib/biblatex-ieee.zip
	# "install" it by running texhash
	unzip biblatex-ieee.zip \
		&& rm biblatex-ieee.zip \
		&& texhash ~/texmf
}

install_latex
#update_biblatex_ieee
install_pplatex pplatex-1.0-rc2

# vim: ts=3 sw=3 sts=0 noet :
