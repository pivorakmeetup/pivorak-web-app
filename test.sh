#!/bin/bash

echo Hello && for COMPONENT in components/*/; do echo  "================== Testing $COMPONENT ==================" && cd $COMPONENT && sh test.sh && cd .. || { echo "$COMPONENT failed" ; exit 1; }; done
