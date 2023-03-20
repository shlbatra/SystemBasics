- IP Address (Internet Protocol)  -> kind of like phone number
- opens up communication between devices
- ability for devices to connect to internet
- ipconfig in windows
- ifconfig in mac
- ipv4 address
    - router -> assigns IP address to device (DHCP)
    - starts with 192.168.1 -> router decided using subnet mask
    - 255 (octet in subnet mask) -> corresponding octet in IP address remain the same in network
    - 192.168.1.204 (192.168.1 -> Network portion and 204 -> Host connect to device)
    - why network portion important ? 
        - if device on same network, then communicate directly
        - if device on diff network, then look at default gateway IP address
          that is router
        - 2 IP address reserved
            - Network address (first IP address) 192.168.1.0
            - Broadcast address (Last IP address) 192.168.1.255
            - Default gateway
        - total available (256-3) = 253 ip addresses
- subnet mask(Netmask)
    - 255.255.255.0
    - 0 -> last number can be anything between 0 and 255
    - 255 - numbers not change
- default gateway(default router)
    - 192.168.1.1

- Max 4.3 Billion IP addresses (2^32)
- classified into classes 
    - IP addresses reserved
    - gave away too many IP addresses
-               Range                               Subnet Mask          Number of Networks    Number of Hosts
A       1.0.0.0  - 126.255.255.255                  255.0.0.0               126                   16777214
B       128.0.0.0 - 191.255.0.0                     255.255.0.0             16384                  65534
C       192.0.0.0 - 223.255.255.0                   255.255.255.0           2097152                254
D       224.0.0.0 - 239.255.255.255                 Multicast
E       240.0.0.0 - 255.255.255.255                 Experimental
- Subnet mask - determine how big network is
- Ex IP address -> 1.0.0.0  and subnet mask -> 255.0.0.0 results is 16.7Mn IP addresses
- Class A -> big companies and govt, very host heavy, 126 networks 
- Can break down class A network into classless network
- 1.1.4.0 with subnet mask 255.255.255.0
- class B assign 16382 networks wit less IP addresses per network
- class C - 2097150 networks
- subnet mask -> determine number of networks and hosts per network
- not use IP addresses 
- class D- multi cast 
- class E - experimental
- number range missing between A & B
    - 127.0.0.0 - 127.255.255.255    subnet mask 255.0.0.0
    - 16 million addresses 
    - loopback address - used for network testing (ping loopback address)
    - ping 127.0.0.1   (ping - are you awake ?)
    - above public ip addresses that can be reached on internet (big network)


- RFC 1918
- Public IP addresses need to be unique
- Private IP Addresses
    - took A,B,C class and assigned to private IP addresses
    - common range home routers use is Class C
    -              Private                         Subnet
    A       10.0.0.0 - 10.255.255.255             255.0.0.0
    B       172.16.0.0 - 172.31.255.255           255.255.0.0
    C       192.168.0.0 - 192.168.255.255         255.255.255.0
    - Private ip addresses are not unique
    - private ip address not connect to internet 
- NAT (Network Address Translation)
    - router give private IP address 
    - home connect to internet (use ISP) -> assign router public up address
    - NAT performed by router
    - automatically translate private IP address to public IP address
    - isp -> public ip address (google - what is my ip address)
    - laptop -> have private ip address
    - device (192.168.1.45) -> Router NAT (11.5.4.28) -> google.com(23.227.38.65)
    - still run out of IPv4 addresses
    - ipv6 addresses -> much bigger (solve problem for now) -> 2^128 total addresses
    - cellphone -> connected to provider (has a public IPv6 addresses)
- Decimal IP Address 
- Binary IP Address (32 bits)
- 1 Byte = 8 Bits
- IP Address, 32 bits, 4 bytes
- 1 - On and 0 -> Off
- 2^7       2^6     2^5     2^4       2^3     2^2    2^1   2^0
- 128       64       32      16        8       4      2     1
- 192 -> 11000000
- 168 -> 10101000
- 1  ->  00000001
- 21 ->  00010101
- 172.16.34.3
- 10101100.0001000.00100010.0000011

- Subnet Mask - tell how big network is and how many ip address (hosts) are
- Every IP address has subnet mask 
- IP -> 192.168.32.5
        11000000.10101000.00100000.00000101
- Subnet Mask -> 255.255.255.0
-       1111111.1111111.1111111.0000000
- subnet mask - which part of IP addresses are network bits
-       11000000.10101000.00100000   (network bits - not change and which network on)
-       00000101   (host bits - every 4th octa - create IP address in network and assigned to host, tell how many hosts in network -> 2^8 = 256)
- Formula to find ip address in network 2^(# of 0s) - 2
- if need 500 ip addresses, need more host bits - extra 0 -> 2^9-2 = 510 
- change subnet 1111111.1111111.1111110.0000000 -> 255.255.254.0 for 510 ip addresses  - numbers are contagious -> 1s will be in row and 0s after, 1s are network bits and 0s are host bits
Qn -> range of ip addresses - what network looks like ?
- subnet to break down network into sub networks
- home network -> 192.168.1.0/24
- subnet mask -> 255.255.255.0
- break subnet mask for sub networks - hack host bits 
- need 4 networks (2 bits required), 17 networks out of existing network (5 bits)
- hack the hist bits -> require to do 2 bits only
- change subnet to 1111111.1111111.1111111.11000000 (flip host bits)
-                    255.255.255.192/26  (new mask) /26 - sider notation (number of bits in network mask)
- 192.168.1.0 (first network) -> how many hosts in it ? broadcast address ?
- in subnet, look for last network bit location (64) to find increment - size of network to get range
- range -> 192.168.1.0 to 192.168.1.63  (first network) - 62 usable hosts
           192.168.1.64 to 192.168.1.127 (second network)
           192.168.1.128 to 192.168.1.191 (third network) 
           192.168.1.192 to 192.168.1.255 (fourth network) 
- subnet mask for each of the above ranges will be 255.255.255.192/26
- 2^(6) - 2 = 62 usable addresses in every sub network
- Steps to create network and subnetworks
    1. Calculate how many host bits you need to hack based on number of subnetworks reqd
    2. hack the host bits (change from 0 to 1)
    3. find the increment (location of last network bit)
    4. create own networks
- 5 networks 
- 1111111.1111111.1111111.11100000
- increment of 32
- 192.168.1.0 (first network)
- range -> 192.168.1.0 to 192.168.1.31  (first network) - 30 usable hosts
           192.168.1.32 to 192.168.1.63 (second network)
           192.168.1.64 to 192.168.1.95 (third network) 
           192.168.1.96 to 192.168.1.127 (fourth network) 
           192.168.1.128 to 192.168.1.159 (fifth network)
- 2^5 - 2 = 30



