fc [-e ename] [-lnr] [first] [last]
       fc -s [pat=rep] [cmd]
              Fix Command.  In the first form, a range of commands from first to last is selected from the history list.  First and last may be  specified  as  a
              string  (to  locate the last command beginning with that string) or as a number (an index into the history list, where a negative number is used as
              an offset from the current command number).  If last is not specified it is set to the current command for listing (so that ``fc  -l  -10''  prints
              the last 10 commands) and to first otherwise.  If first is not specified it is set to the previous command for editing and -16 for listing.

              The  -n option suppresses the command numbers when listing.  The -r option reverses the order of the commands.  If the -l option is given, the com‐
              mands are listed on standard output.  Otherwise, the editor given by ename is invoked on a file containing those commands.  If ename is not  given,
              the  value  of the FCEDIT variable is used, and the value of EDITOR if FCEDIT is not set.  If neither variable is set, vi is used.  When editing is
              complete, the edited commands are echoed and executed.

              In the second form, command is re-executed after each instance of pat is replaced by rep.  A useful alias to use with this  is  ``r="fc  -s"'',  so
              that typing ``r cc'' runs the last command beginning with ``cc'' and typing ``r'' re-executes the last command.

              If  the  first form is used, the return value is 0 unless an invalid option is encountered or first or last specify history lines out of range.  If
              the -e option is supplied, the return value is the value of the last command executed or failure if an error occurs with the temporary file of com‐
              mands.   If  the  second  form  is used, the return status is that of the command re-executed, unless cmd does not specify a valid history line, in
              which case fc returns failure.




history [n]
       history -c
       history -d offset
       history -anrw [filename]
       history -p arg [arg ...]
       history -s arg [arg ...]
              With no options, display the command history list with line numbers.  Lines listed with a * have been modified.  An argument of n  lists  only  the
              last  n  lines.   If the shell variable HISTTIMEFORMAT is set and not null, it is used as a format string for strftime(3) to display the time stamp
              associated with each displayed history entry.  No intervening blank is printed between the formatted time stamp and the history line.  If  filename
              is supplied, it is used as the name of the history file; if not, the value of HISTFILE is used.  Options, if supplied, have the following meanings:
              -c     Clear the history list by deleting all the entries.
              -d offset
                     Delete the history entry at position offset.
              -a     Append the ``new'' history lines (history lines entered since the beginning of the current bash session) to the history file.
              -n     Read  the  history lines not already read from the history file into the current history list.  These are lines appended to the history file
                     since the beginning of the current bash session.
              -r     Read the contents of the history file and use them as the current history.
              -w     Write the current history to the history file, overwriting the history file's contents.
              -p     Perform history substitution on the following args and display the result on the standard output.  Does not store the results in the history
                     list.  Each arg must be quoted to disable normal history expansion.
              -s     Store the args in the history list as a single entry.  The last command in the history list is removed before the args are added.

              If  the  HISTTIMEFORMAT  variable is set, the time stamp information associated with each history entry is written to the history file, marked with
              the history comment character.  When the history file is read, lines beginning with the history comment character followed immediately by  a  digit
              are  interpreted as timestamps for the previous history line.  The return value is 0 unless an invalid option is encountered, an error occurs while
              reading or writing the history file, an invalid offset is supplied as an argument to -d, or the history expansion supplied as  an  argument  to  -p
              fails.

