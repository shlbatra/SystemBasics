#!/bin/bash

# it works until the condition is false and exit when condition true (reverse of while loop)

# until [ condition ];
# do
# //code
# done

i=0
until [ $i -ge 4 ];
do
echo "sahil"
let i++;
done

#print table of 5

i=1
until [ $i -ge 11 ];
do
echo $((5*$i))
let i++;
done