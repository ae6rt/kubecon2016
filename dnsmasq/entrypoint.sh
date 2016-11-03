#!/bin/sh 

set -uxe
 
env | sort
 
NODE_IP=$(ip -oneline -family inet addr show dev eth0 | awk '{split($4, a, "/"); printf a[1]}')

# 169.254.8.53 is the kube-dns clusterIP
dnsmasq --no-daemon --cache-size=1000 --no-resolv --address=/xoomapi/${NODE_IP} --server=169.254.8.53#53
