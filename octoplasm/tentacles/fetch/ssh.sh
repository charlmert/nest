#!/bin/sh

#
# Package: 		Octoplasm
# Description:  ssh tentacle for octoplasm, deals with all remote command
#				execution and result retrieval via ssh
#
# Usage:		./fetch charl@localhost logstreamer access.log
# Description:	Will match the label for any scripts by that name accepting parameters of that struct
#
if [ -z "$1" ]; then
	echo "Usage: $0 user@host||host label parameters"
fi

SSH_BIN=$(which ssh)

PEBBLES_INDEX="/home/charl/scripts/octoplasm/pebbles/index.sh"

HOST=${1:-"localhost"}
LABEL=${2:-"shiny"}
PARAMS=${3:-"kernel"}
if [ ! -z "$4" ]; then
	PARAMS="$PARAMS $4"
fi
if [ ! -z "$5" ]; then
	PARAMS="$PARAMS $5"
fi
if [ ! -z "$6" ]; then
	PARAMS="$PARAMS $6"
fi
if [ ! -z "$7" ]; then
	PARAMS="$PARAMS $7"
fi



SSH_OPT="-C -i /home/charl/.ssh/id_dsa"

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
$SSH_BIN $SSH_OPT $HOST $PEBBLE_SCRIPT $PARAMS
