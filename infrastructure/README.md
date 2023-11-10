# Infrastructure

This project implements a Kubernetes environment in DigitalOcean on version 1.28.2-do.0, using Terraform and kubectl 
for the deployment of an application and its associated infrastructure.

## General Description

The project consists of several parts, including the configuration of Terraform to create Kubernetes resources and a 
set of Kubernetes manifests to configure services and deployments.

### Implementation of Ingress NGINX
For the Ingress NGINX controller, the following command is used for deployment:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml
```

### Cert-Manager
Used to manage the application's TLS certificates.

### Terraform

* `web-service.tf`: Defines a Kubernetes LoadBalancer service to expose the web service.
* `web-deployment.tf`: Creates a deployment for the web application.
* `versions.tf`: Specifies the required versions of Terraform and providers.
* `vars.tf`: Declares variables used in the configuration.
* `secrets.tf`: Configures the necessary Kubernetes secrets for the application.
* `provider.tf`: Sets the configuration of the DigitalOcean provider and Kubernetes.
* `main.tf`: Defines the Kubernetes cluster in DigitalOcean.
* `job-migrate.tf`: Deploys a Kubernetes job for database migrations.
* `dns.tf`: Manages DNS configuration for the web service in DigitalOcean.
* `db-service.tf` and db-deployment.tf: Configure the service and deployment for the PostgreSQL database.

### Kubectl

This section documents the configuration and deployment of Kubernetes components using kubectl.

#### Database

* `db-deployment.yml`: Defines a StatefulSet for the PostgreSQL database.
* `db-service.yml`: Creates a ClusterIP service for the database, allowing internal communication within the cluster.

#### Database Migration
* `job-migrate.yml`: Defines a Job to execute database migrations.

#### Certificado TLS con Cert-Manager
* `db-deployment.yml` (ClusterIssuer): Configures a ClusterIssuer for generating TLS certificates through Let's Encrypt.

#### TLS Secrets

* `secret.yml`: Defines a Kubernetes secret to store the TLS certificate and private key.

#### Web Deployment
* `web-deployment.yml`: Configures a Deployment for the web application.

#### Web Service
* `web-service.yml`: Creates a ClusterIP service for the web application.

#### Ingress
* `web_ingress.yml`: Defines an Ingress for the web application, using the TLS certificate and redirecting traffic to the web service.