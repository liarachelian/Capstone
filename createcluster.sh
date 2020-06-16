#!/bin/bash -x

eksctl create cluster \
 --name udacity-cluster \
 --version 1.16 \
 --without-nodegroup