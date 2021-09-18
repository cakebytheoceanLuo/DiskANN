#!/bin/bash

# ================================================================================
# ========================Begin Of Parameters=====================================
# ================================================================================
DATA_TYPE=uint8
METRIC=l2
INDEX_PREFIX_PATH=/data/diskann-T2-baseline-indices/bigann-1B/R100_L100_B50_M80/R100_L100_B50_M80
NUM_NODES_TO_CACHE=5000000
NUM_THREAD=16
BEAMWIDTH=4
QUERY_FILE=/data/diskann-T2-baseline-indices/bigann-1B/query.public.10K.u8bin
TRUTH_SET_FILE=/data/diskann-T2-baseline-indices/bigann-1B/bigann-1B-gt
RESULT_OUTPUT_PREFIX=/data/0918bigann-answers/

LOG_FILE=/data/0918bigann_search.log
# ================================================================================
# ===========================End Of Parameters====================================
# ================================================================================

echo "Please run this script with root permission."
echo "Copy this file to release/ folder, where project is compiled."

echo "Data Type: uint8 for BIGANN"
echo "Index Path Folder: " $INDEX_PREFIX_PATH
mkdir $RESULT_OUTPUT_PREFIX

if [ "$?" = "1" ]; then
  echo "Fail to mkdir this folder: " $RESULT_OUTPUT_PREFIX
  echo "Please check this folder!"
  echo "Abort Searching!"
else
  echo "NUM_NODES_TO_CACHE: " $NUM_NODES_TO_CACHE
  echo "NUM_THREAD: " $NUM_THREAD
  echo "BEAMWIDTH: " $BEAMWIDTH
  echo "QUERY_FILE: " $QUERY_FILE
  echo "TRUTH_SET_FILE: " $TRUTH_SET_FILE
  K=10
  echo "Top K: " $K
  echo "RESULT_OUTPUT_PREFIX: " $RESULT_OUTPUT_PREFIX
  echo "$LOG_FILE: " $LOG_FILE

  ./tests/search_disk_index $DATA_TYPE $METRIC $INDEX_PREFIX_PATH $NUM_NODES_TO_CACHE $NUM_THREAD $BEAMWIDTH $QUERY_FILE $TRUTH_SET_FILE $K $RESULT_OUTPUT_PREFIX 30 40 50 55 60 62 65 70 80 100 | sudo tee $LOG_FILE
fi


echo
echo
echo