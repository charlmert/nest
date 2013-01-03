#!/bin/bash

# tee prints to stdout, stderr as well as a specified file in append or replace mode
echo "something happening, yeay, term sing" | tee -a /home/charl/sand/tee_logging.txt

# a bash alias can be configured as sub watch points in configuration or dynamically
# with a salsa util (to be created)
# e.g. salsa-watch-add op
# will be able to watch octoplasm output by logging to a file as well as stdout and stderr

# e.g. alias for ls to be watched.
alias='ls *@ | tee -a /tmp/bash.log'

# limitation is that parameters aren't expressed or substituted
# arguments seem to be appended to the total command so shifting
# or chopping the actual string executed could work but the
# best way would be to built something that leeches closer to
# the shell core like a plugin

# see bash-completion bash-builtins


preexec () { 
    echo "trrrrapped $1";
}
preexec_invoke_exec () {
    [ -n "$COMP_LINE" ] && return  # do nothing if completing
    local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;
    preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG
#!/bin/bash
SALSA_TERM=$($(which tty))
SALSA_BASH_WATCH_LOG=~./bash_history_watch.log
SALSA_BASH_WATCH_LOG_CURRENT=/tmp/salsa_bash_history_watch_current.log
shopt -s histappend
shopt -s promptvars
echo $PROMPT_COMMAND >> /tmp/bash.log
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND > $SALSA_BASH_WATCH_LOG_CURRENT 2&>1; /bin/cat $SALSA_BASH_WATCH_LOG_CURRENT >> $SALSA_BASH_WATCH_LOG; echo $SALSA_BASH_WATCH_LOG_CURRENT >> $SALSA_TERM)"

