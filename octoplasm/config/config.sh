#!/bin/bash
# octoplasm configuration

# determine config base_path
# TODO: make these utils available from ENV var
function find_base_path() {
BASE_DIR=`(cd $(dirname $0) && pwd)`

PATH_ARR=( `echo $BASE_DIR | sed s#^.##g | awk 'BEGIN{FS="/"}{for (i=1; i<=NF; i++) print $i}'` )
PATH_LIMIT=${#PATH_ARR[@]}
((PATH_LIMIT=PATH_LIMIT - (($1+1))))
RES_PATH=""

for i in `seq 0 $PATH_LIMIT`; do
    RES_PATH=$RES_PATH`echo /${PATH_ARR[$i]} | tr -d "\n"`
done

echo $RES_PATH
}

# script self aware relative
BASE_PATH_TMP=$BASE_PATH
BASE_PATH=`find_base_path 1`

# salsa integration here, dynamic configurations loaded per pebble
PEBBLES_DIR=$BASE_PATH/pebbles
#source $BASE_DIR/config/build_pebbles_config.sh

# logstreamer pebble config
LOGSTREAMER_LOG_PATH="/var/log:/home/charl/work/localbands/app/logs"

# updating shiny pebbles should be re linked to the to the latest/best_fit_algo pebble
# when salsa finishes it's analysis run

rm -f $BASE_PATH/pebbles/shiny.sh
ln -sf $BASE_PATH/pebbles/logstreamer.sh $BASE_PATH/pebbles/shiny.sh

BASE_PATH=$BASE_PATH_TMP
