#!/bin/bash

echo "Arithmatic Operators"

read -p "Enter n1: " n1
read -p "Enter n2: " n2

echo "Addition: " $((n1+n2))   # run operation by providing within (())

echo "Substraction: " $((n1-n2))

echo "Multiplcation: " $((n1*n2))

echo "Divison: " $((n1/n2))

echo "Modulus: " $((n1%n2))

echo "Increment: " $((n1++))   # print first and then increments
echo "Incremented value:" $n1

echo "Decrement: " $((--n2))   # decrement first and then prints

echo "Relational Operators"

if [ $n1 -eq $n2 -o $n1 -gt $n2 ]  #  gt for greater than , eq for equal -o for OR, -a for AND
then

echo "n1 = n2"

fi
