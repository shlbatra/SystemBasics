#!/bin/bash

# Function is block of code than is reusable 

# Syntax
# functionname(){
#     code
# }

greetings(){
    echo "Hello !"
}

greetings

sum(){
    a=1
    b=6
    c=$(($a+$b))
    echo "Sum of $a and $b is: " $c
}

sum

#Parameterized Function

sum_args(){
    a=$1
    b=$2
    c=$(($a+$b))
    echo "Sum of $a and $b is: " $c
}

sum_args 12 13

greetstudentname()
{
    echo "Name of student is: "$1
}

greetstudentname "Ayush"

#Return value of function -> store using special symbol 

sum_args_ret(){
    a=$1
    b=$2
    c=$(($a+$b))
    return $c
}

sum_args_ret 12 54
ret=$?    # stores the return value from sum_args_ret, gets the last function call returned value
echo "Return value is : " $ret