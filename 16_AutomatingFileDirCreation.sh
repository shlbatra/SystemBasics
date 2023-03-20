#!/bin/bash

# Use case: for loop - create files/directories 

#Directory Creation

current_dir=`pwd` 

for ((i=0; i<=1; i++)){   #create 4 directories
    echo "Enter directory name you want"
    read dirname 
    mkdir $dirname
    echo $current_dir
}

for ((i=0; i<=3; i++)){
        echo "Enter file name you want"
        read filename
        echo $filename
        echo $current_dir
        touch $filename
    }
