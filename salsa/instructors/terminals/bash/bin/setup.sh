#!/bin/bash

function main() {
# script self aware relative
local BASE_PATH=`find_base_path 4`

# custom setup per instructor
sudo ln -sf $BASE_PATH/instructors/terminals/bash/bin/salsa-console.sh /usr/local/bin/salsa-console
echo "salsa-console is now available, run salsa-console to enable bash instructor"
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
