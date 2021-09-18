#!/bin/bash

# ================================================================================
# ========================Begin Of Parameters=====================================
# ================================================================================
#DATA_TYPE=uint8
#DATA_TYPE=int8
DATA_TYPE=float
METRIC=l2
#METRIC=mips
INDEX_PREFIX_PATH=/data/R100_L100_B60_M115_PQ200/R100_L100_B60_M115_PQ200/R100_L100_B60_M115_PQ200
#NUM_NODES_TO_CACHE=1000000
NUM_NODES_TO_CACHE=0
NUM_THREAD=16
BEAMWIDTH=4
QUERY_FILE=/data/query.public.100K.fbin
TRUTH_SET_FILE=/data/text2image-1B-gt
RESULT_OUTPUT_PREFIX=/data/answers/

LOG_FILE=/data/deep_search.log
# ================================================================================
# ===========================End Of Parameters====================================
# ================================================================================

echo "Please run this script with root permission."
echo "Copy this file to release/ folder, where project is compiled."

if [ "$DATA_TYPE" = uint8 ]; then
  echo "Data Type: uint8 for BIGANN, Facebook SimSearchNet++"
elif [ "$DATA_TYPE" = int8 ]; then
  echo "Data Type: int8 for Microsoft SPACEV"
elif [ "$DATA_TYPE" = float ]; then
  echo "float: float for Microsoft Turing-ANNS, Yandex DEEP, Yandex Text-to-Image"
fi

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

  # TODO: input sanitizer
  TODO:
  ./tests/search_disk_index $DATA_TYPE $METRIC $INDEX_PREFIX_PATH $NUM_NODES_TO_CACHE $NUM_THREAD $BEAMWIDTH $QUERY_FILE $TRUTH_SET_FILE $K $RESULT_OUTPUT_PREFIX 10 20 40 80 100 160 320 500 &
  ./tests/search_disk_index $DATA_TYPE $METRIC $INDEX_PREFIX_PATH $NUM_NODES_TO_CACHE $NUM_THREAD $BEAMWIDTH $QUERY_FILE $TRUTH_SET_FILE $K $RESULT_OUTPUT_PREFIX 10 20 40 80 100 160 320 500 | sudo tee $LOG_FILE
fi


