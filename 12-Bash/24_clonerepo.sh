#!/bin/bash

# read link from user, git command and create folder in our system 

echo "Enter repo link: "
read repolink 

domainname="github.com"

getrepo()
{

    if [[ $repolink == *"$domainname"* ]]   #regex to match if github.com part of link
    then 
    echo "Get Repo . Please wait"
    git clone $repolink
    else
    echo "Please enter valid link"
    fi
}

getrepo