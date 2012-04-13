#!/bin/bash
SALSA_BASH_VERSION=0.1

# teach formatting will attempt to train salsa regarding color constants and their usages
# salsa will learn how and what control characters mean and how to interpret during
# analysis runs.

# todo, build this into analysis run
function strip_formatting() {
# TODO: obtain full list of shell formatting commands
# Bash Color Format Constants
BASH_FG="30 31 32 33 34 35 36 37"
BASH_BG="40 41 42 43 44 45 46 47"
BASH_TYPE="1 4 5 7 8"

for X in $BASH_FG; do
	echo "["$X"m"
done

for Y in $BASH_FG; do
	echo "["$Y"m"
done

for X in $BASH_FG; do
	for Y in $BASH_BG; do
		echo "["$X";"$Y"m"
	done
done

for FORMAT in $BASH_TYPE; do
	echo "["$FORMAT"m"
done

}

function main() {
# script self aware relative
local BASE_PATH=`find_base_path 4`
CURR_PATH=$(pwd)
OUTPUT=`cat $BASE_PATH/instructors/terminals/bash/out/*`

for FORMAT in `strip_formatting`; do
	SL_FORMAT=`regex_slashes $FORMAT`
	#OUTPUT=`sed $FORMAT`
	OUPUT=`echo $OUTPUT | sed $(printf "%q" "s#$SL_FORMAT##g")`
done

echo $OUTPUT
}

function bash_slashes() {
	if [ -z "$1" ]; then 
		return ""
	fi

	printf "%q" "$1"
}

function regex_slashes() {
	if [ -z "$1" ]; then 
		return ""
	fi

	OUTPUT=`printf "%q" "$1"`
	OUTPUT=`echo $OUTPUT | sed s#\\\\[#\\\\\\\\[#g`
	echo $OUTPUT
}

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
# TODO: make these utils available from ENV var
function find_base_path() {
local BASE_DIR=`(cd $(dirname $(resolve_link ${BASH_SOURCE[0]})) && pwd)`

local PATH_ARR=( `echo $BASE_DIR | sed s#^.##g | awk 'BEGIN{FS="/"}{for (i=1; i<=NF; i++) print $i}'` )
local PATH_LIMIT=${#PATH_ARR[@]}
((PATH_LIMIT=PATH_LIMIT - (($1+1))))
local RES_PATH=""

for i in `seq 0 $PATH_LIMIT`; do
    RES_PATH=$RES_PATH`echo /${PATH_ARR[$i]} | tr -d "\n"`
done

echo $RES_PATH
}

main $@
