#!/bin/bash
source `dirname $0`/config/config.sh

if [ ! -d "$BASE_DIR" ]; then
  read -p "create $BASE_DIR (y/n)? " ANSWER
  case "$ANSWER" in
    y|Y|yes|Yes)
      echo mkdir -p $BASE_DIR
    ;;
    *)
      echo "to install simply link a tentacle to an alias e.g.\nsudo ln -sf ~/scripts/octoplasm/tentacles/fetch/cmd.sh /usr/bin/op" 
    esac
fi

sudo ln -sf $BASE_DIR/tentacles/fetch/cmd.sh /usr/bin/op

# can be used like such: query logfile matching localbands for php lines
#op log localbands php
