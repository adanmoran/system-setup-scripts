#!/bin/bash

function install_ros_kinetic()
{
    # Setup the source list
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

	 # Get the keys for downloading ROS Kinetic
	 curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -

	 # Update our packages
	 apt-get update

	 # Now install the full ros Kinetic package
	 # apt-get install -y ros-kinetic-desktop-full
	 # Or the ROS kinetic package without 3D/2D simulators, navigation, or perception
	 apt-get install -y \
       ros-kinetic-desktop \
       python-rosinstall \
       python-rosinstall-generator \
       python-wstool \
       python-catkin-tools \
       build-essential \
	 && rosdep init \
	 && rosdep update \
    && chown $USER $HOME/.ros/rosdep/sources/cache/index 
}
install_ros_kinetic
# vim: ts=3 sw=3 sts=0 et ffs=unix fileencoding=utf-8 :
