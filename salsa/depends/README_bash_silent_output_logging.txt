BASH_PROMPT - execute program before showing prompt

SALSA_TERM=$($(which tty))
SALSA_BASH_WATCH_LOG=~./bash_history_watch.log
SALSA_BASH_WATCH_LOG_CURRENT=/tmp/salsa_bash_history_watch_current.log
shopt -s histappend
shopt -s promptvars
echo $PROMPT_COMMAND >> /tmp/bash.log
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND > $SALSA_BASH_WATCH_LOG_CURRENT 2&>1; /bin/cat $SALSA_BASH_WATCH_LOG_CURRENT >> $SALSA_BASH_WATCH_LOG; echo $SALSA_BASH_WATCH_LOG_CURRENT >> $SALSA_TERM)"

trap - execute program before running command
preexec () { 
    echo "trrrrapped $1";
}
preexec_invoke_exec () {
    [ -n "$COMP_LINE" ] && return  # do nothing if completing
    local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;
    preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG


To append to a log file and terminal simultaneously
by changing the command string, adding a | tee -a logfile

| tee, split output to file and term.stdout, term.stderr
# tee prints to stdout, stderr as well as a specified file in append or replace mode
echo "something happening, yeay, term sing" | tee -a /home/charl/sand/tee_logging.txt


Configuring a bash alias per command to be watched - tedious
and too flaki
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

Solid core output redirection / splitting as a bash addon
# deb salsa package that distributes a bash like plugin
# that hooks into just before output is targetted to redirection
# and prints to a log file?? xterm calls it a security risk, .. .
# see bash-completion bash-builtins

Currently the most compatible hassle free solution would be
logging via the container.
# xterm -l will log to the directory it spawned from in the format Xterm.log.mig25-datestamp
xterm -l

# screen terminal emulator also has the ability to log everything executed
# from within the terminal windows into screenlog.0
screen -L

# for salsa 0.1 labelled screen sessions will be run as a requirement
# to enable it as a salsa profile watch point
# put this in ~/.bashrc
screen -S "salsa - bash instructor v0.1" -L
