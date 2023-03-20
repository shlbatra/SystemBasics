#!/bin/bash

# break - it breaks the execution of a loop 
# continue - it skips the execution of loop on certain condition

echo "Break"
for((i=0; i<=10; i++))
{
    if [ $i -eq 3 ]
    then 
    break
    else 
    echo $i
    fi
}

echo "Continue"
for((i=0; i<=10; i++))
{
    if [ $i -eq 5 -o $i -eq 10 ]
    then 
    continue
    else 
    echo $i
    fi
}

# take user input and based on it break statement
echo "Take User Input"
for((i=0; i<=10; i++))
{
    echo "Enter your age: "
    read age 
    if [ $age -lt 18 ]
    then 
    echo "You are not allowed to party"
    break
    else 
    echo "You are allowed to party"
    fi
}