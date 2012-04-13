#!/bin/bash
#
# Package:		Octoplasm
# Description:	Interface to all the available pebbles on this bed
#

# determine config base_path
# TODO: make these utils available from ENV var
function find_base_path() {
BASE_DIR=`(cd $(dirname ${BASH_SOURCE[0]}) && pwd)`

PATH_ARR=( `echo $BASE_DIR | sed s#^.##g | awk 'BEGIN{FS="/"}{for (i=1; i<=NF; i++) print $i}'` )
PATH_LIMIT=${#PATH_ARR[@]}
((PATH_LIMIT=PATH_LIMIT - (($1+1))))
RES_PATH=""

for i in `seq 0 $PATH_LIMIT`; do
    RES_PATH=$RES_PATH`echo /${PATH_ARR[$i]} | tr -d "\n"`
done

echo $RES_PATH
}

function main() {
# script self aware relative
local BASE_PATH=`find_base_path 1`

source $BASE_PATH/config/config.sh

LABEL=${1:-"shiny"}

#TODO: include param struct matcher

# revision 1. in native language
#PEBBLE_FILES=$(find $PEBBLES_DIR | awk 'BEGIN{FS="/"}{for (i=NF; i<=NF; i++) print $i}' | grep $LABEL | grep -E 'sh$')

# revision 2 added nodejs, deps path, changed to include .js
PEBBLE_FILES=$(exec $PEBBLES_DIR/searchstreamer.js $PEBBLES_DIR | awk 'BEGIN{FS="/"}{for (i=NF; i<=NF; i++) print $i}' | grep $LABEL | grep -E 'sh$|js$')
PEBBLE_FILE=$PEBBLE_FILES

if [ -z "$PEBBLE_FILE" ]; then
	exit 1
fi

#for PEBBLE_FILE in $PEBBLE_FILES; do

	#if [ ! -r "$PEBBLE_FILE" ]; then
		#continue
	#fi

	PEBBLE_SCRIPT=$PEBBLES_DIR/$PEBBLE_FILE

	# revision 1 file type checks second column of output for sig
	FILE_TYPE=`file $PEBBLE_SCRIPT | awk '{print $2}'`

# reseach> baloon pin can be added here by commenting out FILE_TYPE from rev 1
#					 failure profiles can be matched and accounted for when
#					 answering control struct questions

	# revision 2 added file type, file type pattern must match nodejs sig
	FILE_TYPE_2=`file $PEBBLE_SCRIPT | awk '{print $3}'`
	
	# revision 1 matches against sig 1.0
	case "$FILE_TYPE" in
		"POSIX" | "Bourne-Again")
			echo $PEBBLE_SCRIPT
			exit 0
		;;
		"symbolic")
			# TODO: enable linked pebbles
			# for now pebbles must live in octoplasm/pebbles/
			echo $PEBBLE_SCRIPT
			exit 0
		;;
		*)
			#Should we log unsearchable file types?
			# revision 2, second fragment answered top question
			#echo "pebble request, $LABEL"
		;;
	esac

	# revision 2 matches against sig 2.0
	case "$FILE_TYPE_2" in
		"nodejs")
			echo $PEBBLE_SCRIPT
			exit 0
		;;
	# revision 2, symbolic logic duplicated.
		*)
			# Should we log unsearchable file types?
			# echo "pebble request, $LABEL"
		;;
	esac

#done

echo $SCRIPT_FILE
}

main $@
