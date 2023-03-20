#!/bin/bash

echo "Read input from user"

echo "Enter your name please: "

read name

echo "Your name is: " $name

read -p "Enter your age: " age     #for prompt provide in single line 

echo "Your age is: " $age

echo "Enter your unknown: "

read

echo "Your unknown is: " $REPLY

read -sp "Enter password" pwd    # not show password when entering 

echo "Your password is: " $pwd
