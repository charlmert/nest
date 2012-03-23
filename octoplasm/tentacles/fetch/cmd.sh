#!/bin/sh

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

PEBBLES_INDEX="/home/charl/scripts/octoplasm/pebbles/index.sh"

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
