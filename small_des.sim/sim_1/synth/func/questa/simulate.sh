#!/usr/bin/env bash
# ****************************************************************************
# Vivado (TM) v2023.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Siemens Questa Advanced Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sun Jan 21 00:28:54 UTC 2024
# SW Build 4029153 on Fri Oct 13 20:13:54 MDT 2023
#
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
bin_path="/cad/Siemens/2022-23/RHELx86/QUESTA-CORE-PRIME_2022.4/questasim/bin"
set -Eeuo pipefail
$bin_path/vsim -64  -do "do {tb_D_FLIPFLOP_simulate.do}" -l simulate.log

