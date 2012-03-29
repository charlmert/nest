BASH BUILTINT COMMANDS:

commands effectively compressed to not needing to specify cd
if the name encountered is a directory.

research> make sure to not conflict with directory search paths
          or the idea of directories as configurable statics.

shopt autocd
autocd  If  set, a command name that is the name of a directory is executed as if it were the argument to the cd command.  This option is only used
                      by interactive shells.


The instructor compliance check should include
- strict
- transitional
- ...

research> bash can run in compatible mode as well. this will
          provide more levels of lazyness with compliance.

					a notion of weight or pull for implementing strict
          shoult be attached and used when selecting pebbles.

compat31
                      If set, bash changes its behavior to that of version 3.1 with respect to quoted arguments to the [[ conditional command's =~ operator.
              compat32
                      If  set,  bash  changes its behavior to that of version 3.2 with respect to locale-specific string comparison when using the [[ conditional
                      command's < and > operators.  Bash versions prior to bash-4.1 use ASCII collation  and  strcmp(3);  bash-4.1  and  later  use  the  current
                      locale's collation sequence and strcoll(3).
              compat40
                      If  set,  bash  changes its behavior to that of version 4.0 with respect to locale-specific string comparison when using the [[ conditional
                      command's < and > operators (see previous item) and the effect of interrupting a command list.
              compat41
                      If set, bash, when in posix mode, treats a single quote in a double-quoted parameter expansion as a special character.  The  single  quotes
                      must match (an even number) and the characters between the single quotes are considered quoted.  This is the behavior of posix mode through
                      version 4.1.  The default bash behavior remains as in previous versions.

