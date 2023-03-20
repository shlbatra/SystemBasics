- Env variable - Key value pair that you can inject inside the process that its running right now on your system
- ex. Pass location in key value pair where store logs. LOG_LOCATION=/path/to/log
- 2 types of Env Variables -
    - Regular Env Variable
    - System Env Variable 

Windows System
1. set INTERVAL=1   #Env variable set up
2. echo %INTERVAL%  #get value of env variable 
-  Env variable belongs to a specific process called Regular Env 
3. You can use environment variable in python script
4. System Env Variables - affect how entire system works, 
    set    #get all environment variables system and the ones with current process
    ex. echo %USERNAME%
5.  User specific system variables 

    Public specific system variables 

6. PATH - environment variable with list of directories. Each directory has program that can run directly from terminal. 
    echo %PATH%     #Even basic executables are in path ex. cd, dir, exit

7. set PATH=C:\myshortcuts      #for this terminal only 
cd myshortcuts 

execute any file directly -> mytext.txt 


LINUX
printenv   =    set
echo %USERNAME%   = echo $USERNAME

1. echo $PATH
2. vim /usr/local/bin/my_executable    
    -> insert   echo "MY CUSTOM COMMAND" 
    EXIT AND SAVE Esc :wq!
3.  chmod +x  /usr/local/bin/my_executable
    my_executable (To run this file)
    O/P -> MY CUSTOM COMMAND 

