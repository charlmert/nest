#!/bin/bash
SALSA_TERM=$($(which tty))
SALSA_BASH_WATCH_LOG=~./bash_history_watch.log
SALSA_BASH_WATCH_LOG_CURRENT=/tmp/salsa_bash_history_watch_current.log
shopt -s histappend
shopt -s promptvars
echo $PROMPT_COMMAND >> /tmp/bash.log
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND > $SALSA_BASH_WATCH_LOG_CURRENT 2&>1; /bin/cat $SALSA_BASH_WATCH_LOG_CURRENT >> $SALSA_BASH_WATCH_LOG; echo $SALSA_BASH_WATCH_LOG_CURRENT >> $SALSA_TERM)"

