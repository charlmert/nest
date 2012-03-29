#!/bin/bash
echo "something happening, yeay, term sing" | tee -a /home/charl/sand/tee_logging.txt


preexec () { 
    echo "trrrrapped $1";
}
preexec_invoke_exec () {
    [ -n "$COMP_LINE" ] && return  # do nothing if completing
    local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;
    preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG
