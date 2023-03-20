#!/bin/bash 
# /dev/null is a special device file that discards all data written to it and returns an end-of-file condition on any read operation
#used to silence output that is not necessary or desired, such as progress information or debugging messages. 
#It can also be used to prevent a command from creating output files or other artifacts that you do not want.
echo "Hello World! I am running Bash Scripting" > /dev/null