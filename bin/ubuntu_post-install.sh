#!/bin/bash
#------------------------------------------------------------------------------
# Copyright (c) 2019 BTA Design Services Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#------------------------------------------------------------------------------
# Authors: Alfredo Herrera  (aherrera@btadesignservices.com) 
#--- 
# This script installs ubuntu extra packages required for RISC-V tools 
# which may be used to study, configure as-referred, modify, implement or 
# release hardware based on the RISC-V Instruction Set Architecture.
# The VM is preconfigured for RISC-V HW development.
#    * RISC-V SW tool chain using the Eclipse-IDE
#    * RISC-V Imperas OVPSim model
#    * RISC-V Verilator model
#------------------------------------------------------------------------------

#--- 
# Exit if not in a script, if not sudo/root or if runtime errors
#--- 
function die() {
  echo "$@: " 1>&2
  exit 1
}
# ref: https://askubuntu.com/a/30157/8698
if ! [ $(id -u) = 0 ]; then
   echo "The Ubuntu post-installation script needs to be run as root." >&2
   exit 1
fi
# Show commands being used and error out on unexpected situations
set -eux 

#--- 
# libudev package not available
echo "Updating Ubuntu"; echo""

apt-get install -y openssh-server xauth git-core lsb-core xorg vim-gtk3 dos2unix autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libusb-1.0-0-dev libudev1 libudev-dev g++ openjdk-8-jdk libfl2 libfl-dev

apt-get upgrade
apt-get clean
apt-get autoremove --purge

#--- 
# Install PULP-Platform GNU toolchain
#--- 
sudo -u user pulp_install.sh

#---
# Install Verilator tool
#---
verilator_install.sh

#---
# Install Elipse-IDE and MCU plugins
sudo -u user eclipse-mcu_install.sh

#---
# Install rv32m1 and OpenOCD tools
#---
sudo -u user rv32m1_install.sh

#---
# Install SEGGER J-Link drivers
#---
apt-get install -f ./JLink_Linux_V650a_x86_64.deb
