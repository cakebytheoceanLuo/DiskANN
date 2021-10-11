#!/bin/bash

DATA_TYPE=float
METRIC=mips
# ================================================================================
# ========================Begin Of Parameters=====================================
# ================================================================================
# DATA_TYPE
# METRIC
INDEX_PREFIX_PATH=/data/diskann-T2-baseline-indices/text2image-1B/R100_L100_B60_M115_PQ200/R100_L100_B60_M115_PQ200
NUM_NODES_TO_CACHE=500000
NUM_THREAD=16
BEAMWIDTH=10
QUERY_FILE=/data/diskann-T2-baseline-indices/text2image-1B/query.public.100K.fbin
TRUTH_SET_FILE=/data/diskann-T2-baseline-indices/text2image-1B/text2image-1B-gt
RESULT_OUTPUT_PREFIX=/data/1011texttoimgae-answers/

LOG_FILE=/data/1011texttoimgae-search.log
# ================================================================================
# ===========================End Of Parameters====================================
# ================================================================================

echo "Please run this script with root permission."
echo "Copy this file to release/ folder, where project is compiled."


echo "float: Yandex Text-to-Image"
echo "Metric: " $METRIC

echo "Index Path Folder: " $RESULT_OUTPUT_PREFIX
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

  ./tests/search_disk_index $DATA_TYPE $METRIC $INDEX_PREFIX_PATH $NUM_NODES_TO_CACHE $NUM_THREAD $BEAMWIDTH $QUERY_FILE $TRUTH_SET_FILE $K $RESULT_OUTPUT_PREFIX 10 20 30 40 50 60 70 80 90 100 | sudo tee $LOG_FILE
fi

echo
echo
echo