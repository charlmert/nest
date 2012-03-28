#!/bin/bash
SCRIPT_SIG=`md5sum $0`

#TODO: make this script use analysis from salsa->bash to open the most viable matching
#      sql client taking into account, output to terminal or not vs open prompt.
#      consider storing passwords in a one way hashing algo as the next step.

# this will open connections to databases based on history and matching labels
# to consider for apache indexing, popular database client names should push weight points
# in the sqlstreamer.sh directions and dynamically re pointed once a new sql type list script becomes available
# on subsequent time series analysis runs

# TODO: make these utils available from ENV var
# resolves symbolic links
function resolve_link() {
  local LINK_FILE=${1:-${BASH_SOURCE[0]}}
  local FILE_TYPE=`file $LINK_FILE | awk '{print $2}'`
  local LINK_TO=$LINK_FILE

  while [ $FILE_TYPE = "symbolic" ]; do
    LINK_TO=$(readlink $LINK_TO)
    FILE_TYPE=$(file $LINK_TO | awk '{print $2}')
  done

  echo $LINK_TO
}

# determine config base_path
function find_base_path() {
BASE_DIR=`(cd $(dirname $(resolve_link ${BASH_SOURCE[0]})) && pwd)`

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

#
# Package:		Octoplasm/Pebbles
# Description:	Trails common logs specified by configuration
#				for information using grep.
#
# Usage:		./logstreamer label options

#TODO: log usage to or incorrect usage to log file
if [ -z "$1" ]; then
	echo -e "Usage: $0 label options"
fi

# compressed command usage options loaded here
# commands must be categorised into an ontology
# commands have profiles that indicate supported input and expected outputs
GREP_BIN=`which mysql`
GREP_PROFILE_TYPE="ASCII"
GREP_PROFILE_PARAMS=2 # where to look for parameter, will be replaced with get_opt

ZGREP_BIN=`which zgrep`
ZGREP_PROFILE_TYPE="gzip"
ZGREP_PROFILE_PARAMS=2

TAIL_BIN=`which tail`
TAIL_PROFILE_TYPE="ASCII"
TAIL_PROFILE_PARAMS=0

GREP_OPT="-i"
ZGREP_OPT="-i"
TAIL_OPT="-F"

# the shiny bin is a link to one of the supported search commands above
# the shiny command will be the one determined by the behavior analyzer
SHINY_BIN=$TAIL_BIN
SHINY_OPT=$TAIL_OPT
SHINY_PROFILE_TYPE=$TAIL_PROFILE_TYPE
SHINY_PROFILE_PARAMS=$TAIL_PROFILE_PARAMS

LABEL=${1:-"messages"}
SEARCH_CMD=${2:-"rsyslogd"}

# Checking every log file in known log locations matching that label
IS_TEXT=False
IS_GZIP=False

TEXT_FILES=""
GZIP_FILES=""
SHINY_FILES=$TEXT_FILES

# TODO: make function return into env var
#get_files_match_label() {
#    LABEL=$1
#    echo `find /var/log | grep $LABEL`
#}

#LOG_FILES=get_files_match_label $LABEL
#echo $LOG_FILE
#exit 1

LOG_LOCATIONS=( `echo $LOGSTREAMER_LOG_PATH | awk 'BEGIN{FS=":"}{for (i=1; i<=NF; i++) print $i}'` )
LOG_COUNT=${#LOG_LOCATIONS[@]}

for i in `seq 0 $LOG_COUNT`; do
  LOG_PATH=${LOG_LOCATIONS[$i]}

	if [ ! -d "$LOG_PATH" ]; then
	  continue
  fi

	#LOG_FILES=`find $LOG_PATH | grep $LABEL`
	# opt: supress errors
	LOG_FILES=`find $LOG_PATH 2>/dev/null | grep $LABEL`
	for LOG_FILE in $LOG_FILES; do
		# using file to determine and check against file type
		# the file command should also be subject to the behavior analyzer

		# the homeostasis of the application should be measurable to ensure
		# it will function to a certain acceptable degree.

		# if the analyzer determines that the file command no longer best fits
		# for this purpose it will use the new command and ensure it's inputs
		# and outputs maintains above an expected percentage.
		FILE_TYPE=`file $LOG_FILE | awk '{print $2}'`

		# every distinct filetype should have a matching category tree that
		# eventually points to the best command that makes use of these types
		# of files/data sources.
		case "$FILE_TYPE" in
			"$SHINY_PROFILE_TYPE")
				SHINY_FILES="$SHINY_FILES $LOG_FILE"
			;;
			*)
				#Should we log unsearchable file types?
			;;
		esac
	done

done

if [ ! -z "$SHINY_FILES" ]; then
	if [ $SHINY_PROFILE_PARAMS = 2 ]; then
		#pebble node type parameter requirements
		$SHINY_BIN $SHINY_OPT $SEARCH_CMD $SHINY_FILES
	else
		$SHINY_BIN $SHINY_OPT $SHINY_FILES
	fi
fi

#TODO: add log file locations
}

main $@
