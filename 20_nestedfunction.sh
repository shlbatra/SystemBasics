#!/bin/bash

# Calling function inside a function 

demo()
{
    echo "This is demo function"
    demo2
}

demo2()
{
    echo "This is demo2 function"
}

demo

# another use case 

sum(){
    echo "Sum of $1 and $2 is: " $(($1+$2))

    sub()
    {
        echo "Difference of $1 and $2 is: " $(($1-$2))
    }
    sub 4 2
}

sum 2 4
