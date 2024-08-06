#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <kafka-pod-name> <topic-name>"
    exit 1
fi

# Assign input arguments to variables
KAFKA_POD_NAME=$1
TOPIC_NAME=$2
NAMESPACE="kafka" # Adjust if your namespace is different

# Execute into the Kafka pod and create the topic
kubectl exec -it $KAFKA_POD_NAME -n $NAMESPACE -- /bin/bash -c "/opt/kafka/bin/kafka-topics.sh --create --topic $TOPIC_NAME --bootstrap-server kafka-cluster-kafka-bootstrap.kafka:9092 --replication-factor 1 --partitions 1"

# Check if the topic was created successfully
if [ $? -eq 0 ]; then
    echo "Topic '$TOPIC_NAME' created successfully."
else
    echo "Failed to create topic '$TOPIC_NAME'."
fi

