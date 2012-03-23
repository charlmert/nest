#
# Package:		Octoplasm
# Description:	Interface to all the available pebbles on this bed
#

PEBBLES_DIR=/home/charl/scripts/octoplasm/pebbles

LABEL=${1:-"shiny"}

#TODO: include param struct matcher

PEBBLE_FILES=`find $PEBBLES_DIR | grep $LABEL`
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
