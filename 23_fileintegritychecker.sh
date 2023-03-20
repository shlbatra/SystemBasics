#!/bin/bash

# get hash of file using md5sum <filename> if changed or not

generatehash()
{
    echo "Enter filename: "
    read filename

    md5 -q $filename > $filename.md5   #store md5 value in file
    echo "Hash value stored in $filename.md5 file"
}

checkhashvalue()
{
    echo "Enter filename: "
    read filename

    generatedhash=$(cat $filename.md5)
    output=$(md5 -q $filename)

    echo "Hash stored previously " $generatedhash
    echo "New hash created :" $output

    if [ "$generatedhash" == "$output" ]
    then 
    echo "There is no change in file"
    else
    echo "There is change in file"
    fi
}

echo "1.Generate hash"
echo "2.Check file integrity"

read -p "Enter your choice: " choice

case $choice in 
1)
echo "Generating Hash"
generatehash
;;
2)
echo "Check file integrity"
checkhashvalue
;;
esac
