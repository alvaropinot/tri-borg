# This Deployment manifest defines:
# - single-replica deployment of the container image, with label "app: go-hello-world"
# - Pod exposes port 8080
# - specify PORT environment variable to the container process
# Syntax reference https://kubernetes.io/docs/concepts/configuration/overview/
apiVersion: apps/v1
kind: Deployment
metadata:
  name: go-hello-world
spec:
  replicas: 1
  selector:
    matchLabels:
      app: go-hello-world
  template:
    metadata:
      labels:
        app: go-hello-world
    spec:
      containers:
      - name: server
        image: gcr.io/GOOGLE_CLOUD_PROJECT/tri-borg:COMMIT_SHA
        ports:
        - containerPort: 8080
        env:
        - name: PORT
          value: "8080"
---
# This Service manifest defines:
# - a load balancer for pods matching label "app: go-hello-world"
# - exposing the application to the public Internet (type:LoadBalancer)
# - routes port 80 of the load balancer to the port 8080 of the Pods.
# Syntax reference https://kubernetes.io/docs/concepts/configuration/overview/
apiVersion: v1
kind: Service
metadata:
  name: go-hello-world-external
spec:
  type: LoadBalancer
  selector:
    app: go-hello-world
  ports:
  - name: http
    port: 80
    targetPort: 8080
