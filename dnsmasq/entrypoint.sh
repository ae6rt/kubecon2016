#!/bin/sh 

set -uxe
 
env | sort
 
CURL_OPTS="-s --retry 5 --retry-delay 5"
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)

NODE_IP=$(ip -oneline -family inet addr show dev eth0 | awk '{split($4, a, "/"); printf a[1]}')

DNS_PORT=$(curl ${CURL_OPTS} -H"Authorization: Bearer $TOKEN" https://${KUBERNETES_SERVICE_HOST}/api/v1/namespaces/kube-system/services/kube-dns | jq -r '.spec.ports[] | select(.protocol=="UDP") | .nodePort')

dnsmasq --no-daemon --cache-size=1000 --no-resolv --address=/xoomapi/${NODE_IP} --server=${NODE_IP}#${DNS_PORT}
