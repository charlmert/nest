#!/bin/bash

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
BASE_PATH=`find_base_path 2`

source $BASE_PATH/config/config.sh

#
# Package: 		Octoplasm
# Description:  cmd tentacle for octoplasm, deals with all local command
#				execution and result retrieval shell
#
# Usage:		./fetch logstreamer access.log
# Description:	Will match the label for any scripts by that name accepting parameters of that struct
#
if [ -z "$1" ]; then
	echo "Usage: $0 label parameters"
fi

PEBBLES_INDEX=$BASE_PATH/pebbles/index.sh

LABEL=${1:-"shiny"}
PARAMS=${2:-"kernel"}
if [ ! -z "$3" ]; then
	PARAMS="$PARAMS $3"
fi
if [ ! -z "$4" ]; then
	PARAMS="$PARAMS $4"
fi
if [ ! -z "$5" ]; then
	PARAMS="$PARAMS $5"
fi
if [ ! -z "$6" ]; then
	PARAMS="$PARAMS $6"
fi

if [ -d "$PEBBLES_DIR" ]; then
	echo "couldn't find pebbles dir '$PEBBLES_DIR'"
	exit 1
fi

#TODO: Must iterate through and execute entire list of pebbles
#PEBBLE_SCRIPTS=`$SSH_BIN $SSH_OPT $HOST $PEBBLES_INDEX $LABEL`
#echo "$PEBBLE_SCRIPTS"
#PEBBLE_SCRIPT=`$PEBBLE_SCRIPTS`
#echo "$PEBBLE_SCRIPT"
#$SSH_BIN $SSH_OPT $HOST $PEBBLES_INDEX $LABEL

PEBBLE_SCRIPT=`$SSH_BIN $SSH_OPT $HOST $PEBBLES_INDEX $LABEL`
$PEBBLE_SCRIPT $PARAMS

# cleanup
BASE_PATH=$BASE_PATH_TMP

