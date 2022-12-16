### Who is
```
$ whois $domain
```
Tell you who register the the domain 

### Sub finder
```
$ sudo apt install subfinder
$ subfinder -d tcm-sec.com

```
searching through sub domains

### Asset finder
```
$ sudo go install github.com/tomnomnom/assetfinder@latest
$ assetfinder tcm-sec.com
```
find sub domains and related domains 


### Go witness
```
$ gowitness file -f ./testdomains.txt ./pics --no-http
```
takes pictures of the sites from a list

### Amass
```
$amss enum -d tcm-sec.com
```
Its slow but detailed 
