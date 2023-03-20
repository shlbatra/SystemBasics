- public ip 
    - access over the internet
- private ip
    - access over local LAN
    - Example IPs
        -  10.0.0.0
        - 172.16.0.0
        - 192.168.0.0
- Subnetting
    - helps utilize network bandwidth intelligently
    - divide network into multiple networks called subnetting
    - Internet(145.25.0.0) -> Router -> Subnetting -> a. 145.25.16.0  b. 145.25.32.0
    - Subnet Mask (specify how many bits given to network vs host)
    ex. Class A -> 255.0.0.0  Class B -> 255.255.0.0  Class C -> 255.255.255.0
    - Network Identifier + Subnet Identifier + Host Identifier
    - CIDR (Classless Inter Domain Routing) -> identify which bit of IP address network vs host 
    ex. Class C -> 202.201.150.10/27  (27 bits are network - 3 taken from host as well)
    - Network Id -> Every subnet starting IP - with which connect to network via router
    - Broadcast ID -> last Ip for subnet -> talk to all hosts in your subnet. 
    - Ex. 205.150.65.0/26  -> in 32 bits IP address, 26 bits network (Class C ex. )
      11111111  11111111  11111111  11000000
      Subnet mask -> 255.255.255.192
      Network Id -> logical AND between IP address and subnet 
      IP address to binary -> 11001101.10010110.01000001.00000000
      Network Id -> 11001101.10010110.01000001.00000000 (Class C) -> 205.150.65.0
      How many subnet possible -> 2^n = 2^2 = 4 ( 2 bits of host given to network) 
      Number of hosts -> 2^n - 2 = 2^6-2 = 62 (2 to network so 6 remaining to hosts)
      Broadcast IP -> Starting IP -> 205.150.65.0 + 62 hosts (Last IP)
      Host range  ->   205.150.65.1 to 205.150.65.62
      So broadcast IP will be 205.150.65.63
      Next network ID -> 205.150.65.64 (get 4 subnets)
    - Ex. 205.150.65.0/24 (Class C) -> create 10 subnets with this IP address
     For creating number of subnets, 2^n -> n = 4 for 10 subnets
     CIDR Range -> 205.150.65.0/28 (get 4 host bits to network bits)
     Subnet mask -> 255.255.255.240
     Network Id -> Subnet mask AND IP address -> 205.150.65.0
     Number of hosts per subnet -> 2^4 - 2 = 14 hosts
     Host range -> 205.150.65.1 to 2015.150.65.14
     Broadcast ip for first subnet -> 205.150.65.15 
- TCP vs UDP
    - protocols in networkings
    - Transmission Control Protocol (Reliable eComm experience) vs User Datagram Protocol (Live TV)
    - based on IP protocol, transfer info from 1 device to another
    - Insta dm (TCP, handshake) vs Insta stories (UDP, broadcast)
    - TCP - FTP, HTTP, SMTP for email, TELNET reach device on specific port (12 fields)
    - UDP - DNS (domain name server), DHCP (get IP address once on network), VOIP (4 fields)
    









