#!/usr/bin/env bash
# ****************************************************************************
# Vivado (TM) v2023.2 (64-bit)
#
# Filename    : compile.sh
# Simulator   : Siemens Questa Advanced Simulator
# Description : Script for compiling the simulation design source files
#
# Generated by Vivado on Sun Jan 21 00:28:51 UTC 2024
# SW Build 4029153 on Fri Oct 13 20:13:54 MDT 2023
#
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
#
# usage: compile.sh
#
# ****************************************************************************
bin_path="/cad/Siemens/2022-23/RHELx86/QUESTA-CORE-PRIME_2022.4/questasim/bin"
set -Eeuo pipefail
source tb_D_FLIPFLOP_compile.do 2>&1 | tee compile.log

