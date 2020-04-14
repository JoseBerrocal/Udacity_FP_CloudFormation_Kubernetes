#!/bin/bash

OUTPUT="$(aws cloudformation list-exports | grep -A2 "UdacityFinalPro-Kube-Node-InstanceRole" | awk -F'"' '{ print $4 }'| grep arn )"
echo "${OUTPUT}"

sed -i "s|<ARN of instance role>|${OUTPUT}|g" ./infraestructure/aws-auth-cm.yaml
