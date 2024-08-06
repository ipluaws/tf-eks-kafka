#!/bin/bash

# Define paths to your Helm charts
PRODUCER_HELM_CHART="../producer/"
CONSUMER_HELM_CHART="../consumer/"

# Define release names
PRODUCER_RELEASE_NAME="producer"
CONSUMER_RELEASE_NAME="consumer"

# Define namespaces
NAMESPACE="default"

# Function to uninstall a Helm release
uninstall_helm_release() {
    local release_name=$1

    echo "Checking if release $release_name exists..."
    if helm list --namespace $NAMESPACE | grep -q $release_name; then
        echo "Uninstalling Helm release $release_name..."
        helm uninstall $release_name --namespace $NAMESPACE
        if [ $? -eq 0 ]; then
            echo "Successfully uninstalled $release_name."
        else
            echo "Failed to uninstall $release_name."
            exit 1
        fi
    else
        echo "Release $release_name does not exist. Skipping uninstallation."
    fi
}

# Function to install a Helm chart
install_helm_chart() {
    local chart_path=$1
    local release_name=$2

    echo "Installing Helm chart for $release_name from $chart_path..."

    # Create namespace if it does not exist
    kubectl get namespace $NAMESPACE >/dev/null 2>&1 || kubectl create namespace $NAMESPACE

    # Install the Helm chart
    helm install $release_name $chart_path --namespace $NAMESPACE

    if [ $? -eq 0 ]; then
        echo "Successfully installed $release_name in namespace $NAMESPACE."
    else
        echo "Failed to install $release_name."
        exit 1
    fi
}

# Uninstall existing Helm releases if they exist

uninstall_helm_release $PRODUCER_RELEASE_NAME
uninstall_helm_release $CONSUMER_RELEASE_NAME

# Install Helm charts

install_helm_chart $PRODUCER_HELM_CHART $PRODUCER_RELEASE_NAME
install_helm_chart $CONSUMER_HELM_CHART $CONSUMER_RELEASE_NAME

echo "All Helm charts have been processed."

