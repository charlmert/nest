#!/bin/bash
SCRIPT_SIG=`md5sum $0`

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

PEBBLES_DIR=$BASE_PATH/pebbles

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
GREP_BIN=`which grep`
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
LOG_COUNT=${#PATH_ARR[@]}

for i in `seq 0 $LOG_COUNT`; do
  LOG_PATH=${PATH_ARR[$i]}

	LOG_FILES=`find $LOG_PATH | grep $LABEL`
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
		#grep type parameter requirements
		$SHINY_BIN $SHINY_OPT $SEARCH_CMD $SHINY_FILES
	else
		$SHINY_BIN $SHINY_OPT $SHINY_FILES
	fi
fi

#TODO: add log file locations

BASE_PATH=$BASE_PATH_TMP
