#!/bin/bash

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

function setup() {
local BASE_DIR=`(cd $(dirname $(resolve_link ${BASH_SOURCE[0]})) && pwd)`

sudo rm -f /usr/bin/op
sudo ln -sf $BASE_DIR/tentacles/fetch/cmd.sh /usr/bin/op

# can be used like such: query logfile matching localbands for php lines
#op log localbands php
}

setup $@
