# aws-rds-kratix-promise

This project provides a Kubernetes operator for managing AWS RDS instances using a Kratix-backed state store. This promise uses aws controllers(ACK) for kubernetes as the underlying operator/controller. Aws-rds kratix promise can be used to enforce company standards, security and rules.
This promise is the starting point to create a promise using ACK's so that aws rds resource can be created by the application developer from the EKS cluster itself independently without relying on platform engineering team and needing to have separate access to AWS cloud.

[![Entrypoint](https://github.com/opencredo/aws-rds-kratix-promise/actions/workflows/entrypoint.yml/badge.svg)](https://github.com/opencredo/aws-rds-kratix-promise/actions/workflows/entrypoint.yml)

## Prerequisites

- A running EKS cluster
- Kratix [see install guide](https://docs.kratix.io/main/guides/installing-kratix/single-cluster)
- Docker environment with the ability to build images for both amd64 or arm64 architectures.

## Note
We have tried running this on local kubernetes clusters(minikube and kind) instead of EKS but there are many challenges in it since we are using ACK's for this promise, and they were primarily written to work best on the EKS clusters.
We have detailed information about this promise [here](https://opencredo.atlassian.net/wiki/spaces/ADA/embed/434339842)

### Setup (Promise)
```bash
kubectl apply --context $PLATFORM --filename promise.yaml

```
```bash
kubectl --context $WORKER get pods --watch
```

### Setup (Request)
Once the rds operator is running as seen in the previous step you are ready to fulfil a [resource-request](resource-request.yaml) as a RDSInstance job:
```bash
kubectl apply --context $PLATFORM --filename resource-request.yaml
```

### Kratix Verification
```bash
kubectl --context $PLATFORM get crds awsrds.example.promise.syntasso.io

kubectl logs -l=kratix-promise-id=awsrds -n kratix-platform-system -c aws-rds-promise-pipeline

```

### Teardown (Request)
```bash
kubectl delete --context $PLATFORM --filename resource-request.yaml
```

### Teardown (Promise)
```bash
kubectl delete --context $PLATFORM --filename promise.yaml

```

## References
1. [Kratix docs](https://docs.kratix.io/)
2. [Aws controllers for kubernetes docs](https://aws-controllers-k8s.github.io/community/docs/community/overview/)