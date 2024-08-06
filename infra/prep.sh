#!/bin/bash

# Get account ID and cluster name using AWS CLI
account_id=$(aws sts get-caller-identity --query Account --output text)
cluster_name=$(aws eks list-clusters --query "clusters[0]" --output text)
region=$(aws configure get region --output text)

echo "AWS region: $region"

aws eks --region "$region" update-kubeconfig --name $cluster_name

kubectl create namespace kafka
