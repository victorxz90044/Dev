# NetCat
> a very lightweight network security tool aka swiss army knife for tcp/ip

- lets two computers transferred data with other via tcp ad upd protocols AND IP protocol 
- runs as a client who initiate connections with other computers
- it can operate as a server/listener 
- also a hacking tool used for spying on networks, seeking out vulns, circumventing firewalls, and exploiting backdoors 
- e flag is an interactive interface ( backdoor) that gives unrestricted access to the cmd.exe
- security risk because it transmits data in clear text without encryption

### Common Uses 
- diagnose faults and problems that jeopardize the functionality and security of a network  
- file transfer
- banner grabbing 
- port scanning

### NetCat flags 
 - 4 forces the use of ipv4 
 - 6 forces the use of ipv6
 - d releases netcat from the console
 - D activates the option for debugging sockets
 - h displays help
 - i delays in seconds for sent lines or scanned ports
 - l listen and server mode for incoming connection requests 
 - L listen harder, netcat also continues to operate in listen mode after client-side connection terminations
 - n only ip numbers, no dns names
 - o file, a hex dump is carried out for the data traffic( content of files represented in hexadecimal view)
    - used for fault finding (debugging network applications)
    - recording and sniffing communication is possible ( for outgoing and incoming packages)
- p port, enters the local source port that netcat should use for outgoing connections 
- r use of random port values when scanning (for local and remote ports)
- s address, defines the local source address( ip address or name)
- t telnet mode, requires a special compilation of netcat otherwise option is not available
- u use of udp mode
- U gateway, uses unix domain sockets
- v extensive output
- w defines timeouts
- z port scanner mode ( zero i/o mode)
    - only listening services are scanned ( no data sent)

### Common commands

- set client 
    - 'nc [options] [IP address/host name] [port]'
- set server 
    - 'nc -l -p port [options] [host name] [port]'
    - 'nc -v -w 2 -z 192.168.10.1 1-1024'
- Running a port scan
    - ' nc [options] [host] [port]'
- copying files with netcat
    - text_file.txt file is copied from computer A(client) to computer b(server) via port 6790
    - computer B acts as the receiving server
        - 'nc -l -p $port > text_file.txt'
    - computer A acts as the sending client
        - 'nc $ip_computer_B $port < text_file.txt' 

