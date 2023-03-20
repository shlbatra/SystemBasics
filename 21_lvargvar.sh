#!/bin/bash

# Local Variable -> variable that is declared inside function 
# Glocal Variable -> variable that is declared outside function scope

gvar=20

func1()
{
    a=10;  #local variable
    echo "Local variable" $a
    echo "global variable from local" $gvar
}

echo "global variable" $a

echo "global variable" $gvar

func1

