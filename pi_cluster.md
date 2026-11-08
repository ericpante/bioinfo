# Building a raspberrypi cluster
2026-11-02: first test

# Resources 

Garrett Mills' [Building a a Raspberry Pi Cluster](https://glmdev.medium.com/building-a-raspberry-pi-cluster-784f0df9afbd)

QuantPy's [Raspberry Pi Supercomputer for Quants](https://www.youtube.com/watch?app=desktop&v=l5n62HgSQF8)
## hardware
- compute nodes = 4 RPi5 8GB
- login node = RPi5 8GB
- 5 port PoE+ switch (only 4 ports with PoE; 5th for input)
- OS compute nodes: RASPBERRY PI OS Lite (32 bits) 2026-11-02 ~0.4Gb
- OS login nodes: UBUNTU LTS 24.4

## install
- OS install, ssh enabling: see quantpy
- getting ip addresses: we are on the university network -> get MAC address and provide it to IT so they can allow access. get the MAC addresse with `cat /sys/class/net/eth0/address`


