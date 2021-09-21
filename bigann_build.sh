#!/bin/bash

DATA_TYPE=uint8
METRIC=l2
# ================================================================================
# ========================Begin Of Parameters=====================================
# ================================================================================
# DATA_TYPE
# METRIC
DATA_FILE=/data/bigann-1B/base.1B.u8bin
INDEX_PATH=/data/SelfBuilt_R100_L100_B50_M80/
INDEX_PATH_PREFIX=${INDEX_PATH}R100_L100_B50_M80
R=100 # the degree of our graph index, typically between 60 and 150.
L=100 # the size of search list we maintain during index building.
B=50  # bound on the memory footprint of the index at search time.
M=80  # Limit on the memory allowed for building the index.
T=64  # NUM_THREAD

LOG_FILE=/data/0919bigann_build.log
# ================================================================================
# ===========================End Of Parameters====================================
# ================================================================================

echo "Please run this script with root permission."
echo "Copy this file to release/ folder, where project is compiled."

echo "Data Type: uint8 for BIGANN"
echo "Input Dataset File: " $DATA_FILE
echo "Index Path Folder: " $INDEX_PATH_PREFIX

mkdir $INDEX_PATH

echo "R (Degree of the graph): " $R
echo "L (The size of search list while building): " $L
echo "B (Bound on the memory while searching): " $B
echo "M (Bound on the memory while building): " $M
echo "T (Number of threads): " $T

echo "$LOG_FILE: " $LOG_FILE

nohup ./tests/build_disk_index $DATA_TYPE $METRIC $DATA_FILE $INDEX_PATH_PREFIX $R $L $B $M $T 0 | sudo tee $LOG_FILE &

echo
echo
echo