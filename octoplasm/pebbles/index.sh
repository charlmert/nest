#!/bin/bash
#
# Package:		Octoplasm
# Description:	Interface to all the available pebbles on this bed
#

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

source $BASE_PATH/config/config.sh

LABEL=${1:-"shiny"}

#TODO: include param struct matcher

PEBBLE_FILES=`find $PEBBLES_DIR | awk 'BEGIN{FS="/"}{for (i=NF; i<=NF; i++) print $i}' | grep $LABEL | grep -E 'sh$'`
echo $PEBBLE_FILES
exit 0
for PEBBLE_FILE in $PEBBLE_FILES; do
	FILE_TYPE=`file $PEBBLE_FILE | awk '{print $2}'`

	case "$FILE_TYPE" in
		"POSIX")
			SCRIPT_FILE=$PEBBLE_FILE
		;;
		"symbolic")
			SCRIPT_FILE=$PEBBLE_FILE
		;;
		*)
			#Should we log unsearchable file types?
		;;
	esac
done

echo $SCRIPT_FILE

BASE_PATH=$BASE_PATH_TMP
