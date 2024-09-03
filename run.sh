#!/bin/bash

# Check if minikube is already running
if minikube status | grep -q "Running"; then
  echo "minikube is already running."
else
  # Start minikube
  minikube start
fi

# Apply resources
kubectl apply -f mongo-config.yaml
kubectl apply -f mongo-secret.yaml
kubectl apply -f mongo.yaml
kubectl apply -f webapp.yaml

# Wait for all pods to be ready
kubectl wait --for=condition=Ready pods --all --timeout=300s


# start webapp
minikube service webapp