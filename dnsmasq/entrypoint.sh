#!/bin/sh 

set -uxe
 
env | sort
 
NODE_IP=$(ip -oneline -family inet addr show dev eth0 | awk '{split($4, a, "/"); printf a[1]}')

KUBE_DNS_CLUSTER_IP=169.254.8.53

dnsmasq --no-daemon --cache-size=1000 --no-resolv --address=/xoomapi/${NODE_IP} --server=${KUBE_DNS_CLUSTER_IP}#53
