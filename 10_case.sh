#!/bin/bash
# based on grade, print something

read -p "Enter grade: " grade

case $grade in
   A)
     echo "Your marks is betwen 90-100"
     ;;   # syntax for using switch case - add this here
   B)
     echo "Your marks is in between 81-90"
     ;;
   C)
     echo "Your marks is in between 71-80"
     ;;
   *)   # if not match any case statements above 
     echo "Your marks is below 70"
esac
   