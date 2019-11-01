#!/bin/bash

# This script installs latex tools that are essential for 
# both compiling and displaying latex nicely

function install_latex() {
	# Install latex, zathura, and the tools for building latex
	apt-get install -y texlive-full \
		zathura \
		xdotool \
		latexmk
}

# vim: ts=3 sw=3 sts=0 noet :
