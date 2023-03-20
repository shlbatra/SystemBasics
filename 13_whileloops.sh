#!/bin/bash

# it works until the condition is true 

# while [ condition ];
# do
# //code
# done

i=0
while [ $i -le 4 ];
do
echo "sahil"
let i++;
done

myarr=(1 2 3 4 5)
i=0
while [ $i -le 3 ];
do
echo ${myarr[i]}
let i++;
done