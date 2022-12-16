
### Explainshell.com  

Breaks down in a clean format the terminal commands  

 

### Locate vs find  

 

### File permissions 

- [dir,file, or link] [Owner of the file] [Group] [All user] 
    - Defaults with rw,r,r 

- $chmod  [owner][group][all] (eg 777) 
    - Octal Binary 011 101 File 

### User 

- Sudo adduser mike 

- Switch to mike 

    - Su mike  
- Passwd file 

- Name of user, home folder, shell  

- /etc/sudoers 

- List of user permissions 
- Grep 
    - Pull information from file  
    - $ grep 'sudo' /etc/group 

### Services 

- $ Sudo service apache2 start 

- $ Sudo service apache2 stop 

### Will start on boot 

- $ sudo systemctl enable ssh 

### Web file server 
- $ python3 –m http.server 80 

### Bash script 
- $ Ping $ip –c 1 > ip.txt 
- $ Cat ip.txt | grep "64 bytes" | cut –d " " -f 4 | tr –d ":" 

### File 

```
#!/bin/bash 

For ip in `seq 1 254`; do 

Ping –c 1 192.168.5.$ip | grep "64 bytes" | cut –d " " -f 4 | tr –d ":" & 

Done 
```
 

### You can run it as terminal command  
- $0 is the script 
- $1 any argument after  
- For ip in $(cat ips.txt); do nmap $ip; done 

 

 

 

 