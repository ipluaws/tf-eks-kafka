#!/bin/bash

curl -o aws-ebs-csi-driver.yaml https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/deploy/kubernetes/base/kustomization.yaml
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=master"

helm repo add strimzi https://strimzi.io/charts/

helm install strimzi-cluster-operator strimzi/strimzi-kafka-operator --namespace kafka
