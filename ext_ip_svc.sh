#!/bin/bash
set -x #echo on

OUTPUT="$(kubectl describe services hello-world-svc-http | grep "LoadBalancer Ingress" | egrep "[^  ]+$" -o)"

echo "${OUTPUT}"

echo "Access the following URL http://${OUTPUT}:80"
