#!/bin/bash

DATA_TYPE=float
METRIC=l2
# ================================================================================
# ========================Begin Of Parameters=====================================
# ================================================================================
# DATA_TYPE
# METRIC
DATA_FILE=/data/deep-1B/base.1B.fbin
INDEX_PATH=/data/SelfBuilt_R100_L100_B50_M110/
INDEX_PATH_PREFIX=${INDEX_PATH}R100_L100_B50_M110
R=100 # the degree of our graph index, typically between 60 and 150.
L=100 # the size of search list we maintain during index building.
B=50  # bound on the memory footprint of the index at search time.
M=110  # Limit on the memory allowed for building the index.
T=64  # NUM_THREAD

LOG_FILE=/data/0928bigann_build.log
# ================================================================================
# ===========================End Of Parameters====================================
# ================================================================================

echo "Please run this script with root permission."
echo "Copy this file to release/ folder, where project is compiled."

echo "Data Type: float for DEEP"
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