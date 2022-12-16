### Kioptrix
- in nat network
- username is john
- pass is TwoCows2

### Scanning
---
```
$ sudo netdiscover -r 192.168.138.0/24
```
Going to do an arp scan

##### Three way handshake 
- syn synack rst


##### Nmap
> allows port scanning 
> nmap -A -sV -sC -T4 $ip

Stealth scan is the default scans
- ping scan
- 
```
nmap $ip -p- -T4 -A
```

##### Enum against a website
---
- go to the website
	- http vs https
	- default webpage
	- information disclosure
	- weak encryption 
		- nmap -p443 --script=ssl-enum-ciphers $ip
	- nikto will get you ip banned in the real world
		- nikto -h $httpSite
- Security Headers
	- securityheaders.com
- foxyproxy firefox standard
- burpsuit
	- proxy tab
		- options
			- find the listener and add to foxyproxy
	- http://burp
		save the CA cert
	- firefox setting
		- security
			- view certifices
				- import
					- import that CA cert
	- burp > target 
		-  you see the request and response 