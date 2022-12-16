# VMStat
> is a built in monitoring tool in Linux

- information about memory, system processes, paging, interrupts, block i/o, disk, and cpu scheduling

### VMstat flags
- 'vmstat [options] [delay [count]]
- a active and inactive memory
- f number of forks
- m slab stats
- n displays the header only once rather than periodically
- s a table of various events counters and memory stats
- d disk stats
- D disk activity report
- p partition stats
- t adds a timestamp to the report
- s unit, switches output units
- V version information
- h help

### Basic vmstat output
- process stats
    - r active process 
    - b sleeping process
- memory stats
    - swpd total virtual memory
    - free total free memory
    - buff total temp memory ( data buffer)
    - cache total cache memory
- swap
    - si rate of swapping-in memory from disk
    - so rate of swapping-out memory to disk
- i/o stats
    - bi blocks received from block device per sec
    - bo blocks sent to a block device per sec
- system 
    - in the number of system interrupts
    - cs the number of context switches per sec
- cpu stats
    - us percent of cpu time spent on non-kernel processes
    - sy percent of cpu time spent on kernel processes 
    - id percent of idle cpu
    - wa percent of cpu spent waiting for input/output
    - st percent of cpu time stolen by a virtual machine
 
