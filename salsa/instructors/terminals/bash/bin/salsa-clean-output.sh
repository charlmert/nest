#!/bin/bash
SALSA_BASH_VERSION=0.1

# teach formatting will attempt to train salsa regarding color constants and their usages
# als salsa will learn how and what control charachters mean and how to interpret during
# analysis runs.

# todo, build this into analysis run
function strip_formatting() {
# TODO: obtain full list of shell formatting commands
# Bash Color Format Constants
BASH_FG="30 31 32 33 34 35 36 37"
BASH_BG="40 41 42 43 44 45 46 47"
BASH_TYPE="1 4 5 7 8"

for FORMAT in $BASH_FG; do
	echo "color const: \[\033["$FORMAT"m\]"
done
}

function main() {
# script self aware relative
local BASE_PATH=`find_base_path 4`
CURR_PATH=$(pwd)
#cat $BASE_PATH/instructors/terminals/bash/out/*
strip_formatting
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
