#!/bin/bash

# workflow -> read username, provide systempassword and then delete user   (cat /etc/passwd) - has all users

#global variables
read "Enter username"
read username
read "Enter password"
read systempassword

deluser()
{
    echo $systempassword | sudo -S deluser $username  # -S when take password as piped
}

# call function
deluser