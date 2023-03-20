#!/bin/bash

# find open ports in system 
# read hostname (domain or ip), nmap commands to scan hostname, 
# use scanme.nmap.org -> test domain (65536 ports) -> tell which port open in your system 

echo "Enter hostname"

read hostname

echo "Enter system password"

read -s systempassword     # not visible what enter

nmapfunction()
{
    echo $'1. Normal Scan\n2.TCP Scan\n 3. UDP Scan'
    read -p "Choose option" option

    case $option in 
    1)
      echo "Normal Scan"
      echo $systempassword | sudo -S nmap $hostname
      ;;
    2)
      echo "TCP Scan"
      echo $systempassword | sudo -S nmap -sT $hostname
      ;;
    3)
      echo "UDP Scan"
      echo $systempassword | sudo -S nmap -sU $hostname
      ;;
    *)
      echo "Please enter valid option"
    esac
}

nmapfunction