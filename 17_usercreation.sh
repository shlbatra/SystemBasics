#!/bin/bash

# for loop - username input and password choice

for ((i=0; i<=2; i++))
{
    echo "Enter your choice: "
    read choice

    if [ $choice -eq 1 ]
    then 
    echo "Enter username: "
    read username

    echo "Enter password: "
    read password

    sudo useradd -m 0s /bin/bash $username

    echo "$username:$password" | sudo chpasswd # add password to system   # login using su <username>

    else
    break
    fi
}