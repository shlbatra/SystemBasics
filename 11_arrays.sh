#!/bin/bash

echo "Array is data structure which is used for storing multiple values in single variable"

namelist=(A B C D); # initialize array with values 

# Array Indexing - access elements of array

echo "First element:" ${namelist[0]}  # first element of array
echo "Third element:" ${namelist[2]}
echo "No index:" ${namelist[9]}

# print all elements of array - using *
echo "All array elements: " ${namelist[*]}

# print all elements of array - using @
echo "All array elements: " ${namelist[@]}