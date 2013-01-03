#!/bin/bash
shopt -s histappend
shopt -s promptvars
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
