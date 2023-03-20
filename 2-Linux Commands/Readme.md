- 12 Linux Commands
1. grep -> search anything on your system.
ex. grep "root" -n /etc/passwd (with line number)
grep -nv "root" /etc/passwd (line number and lines that dont have root)
grep -r "root" /etc (get all files containing root keyword)
2. cat/tail/head -> read files
cat /etc/passwd (file with users on system)
tail -n 5 /etc/passwd (read last 5 lines, default without n is 10 lines)
head /etc/passwd (read first 10 lines)
3. top -> list all processes on system 
change refresh cycle from 3 to 1sec - interact with s
check processes by a user ex. root -> interact with u
to exit, q command 
for help, h command
4. lsblk/df -> all block devices on your system
lsblk --fs (get more metadata)
df -> all info about filesystem that exist on your system, provide disk usage
5. netstat for mac -> networking commands 
ss (check all active connections)
ss -tulpn (all established connections)
ping -> test connections 
nmcli -> configure networking devices ex. change ip address
6. systemctl/launchctl for mac -> display all services , interactive command
systemctl start stop restart reload <servicename>
reload - reload only changes made to config file - less down time
ex. systemctl reload sshd.service
7. w -> currently logged in users . to know if restart server 
8. find -> find files created by a specific user
ex. find / -user jsc (find all files owned by user jsc)
find / -size +100M (find files with 100mb size)
find / -size +100M 2>/dev/null (to skip errors)
find / - (tab) - very powerful command
9. jounalctl -> query logs across system
journalctl --follow (see logs in real time)
logger -p "auth.debug" "DEBUG THE AUTHENTICATION LOG" -> throwing your own logs
10. 