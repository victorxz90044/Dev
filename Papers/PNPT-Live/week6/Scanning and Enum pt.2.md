### dirbuster
select target
usr/share/dirbuster/wordlist
file extension base on your finds

### ffuf
- w 
	- wordlist
- u
	- url
- recursion 
- e
	- extensions
```
ffuf -w $wordListDir:FUZZ -u $target -recursion -e php,html
```

### SMB 
##### smbclient
check all open file shares
```
smbclient -L \\\\192.168.138.143\\
```

### Metasploit
enter metasploit
```
  $ msfconsole
```
Searching through the database
```
$ msf6 > search auxilairy/scanner/smb/smb_version
$ msf6 > use auxilairy/scanner/smb/smb_version
$ msf6 auxiliary(scanner/smb/smb_version) > options
$ set RHOSTS 192.168.138.143
$ run
$ exit
``` 

### searchploit

exploit-db.com
