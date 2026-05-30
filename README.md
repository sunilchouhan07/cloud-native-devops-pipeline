# 🚀 Cloud Native DevOps Pipeline on AWS EKS

An end-to-end **Cloud Native DevOps Platform** built on AWS that demonstrates modern DevOps practices including **Infrastructure as Code**, **CI/CD**, **GitOps**, **Kubernetes**, **Monitoring**, **Logging**, and **Alerting**.

The project provisions cloud infrastructure using Terraform, deploys workloads on Amazon EKS, automates application delivery with GitHub Actions and ArgoCD, and provides complete observability using Prometheus, Grafana, Loki, Promtail, and Alertmanager.

---

# 📌 Project Overview

This project demonstrates how modern DevOps tools work together in a production-style environment.

### Features

* Infrastructure as Code using Terraform
* Kubernetes on Amazon EKS
* GitOps using ArgoCD
* CI/CD using GitHub Actions
* Docker image build and push to Amazon ECR
* 3-Tier Employee Management Application Deployment
* Monitoring using Prometheus and Grafana
* Centralized Logging using Loki and Promtail
* Alerting using Alertmanager
* Slack Notification Integration

---

# 🏗️ Architecture

```text
Developer
    ↓
GitHub
    ↓
GitHub Actions
    ↓
Amazon ECR
    ↓
GitOps Repository Update
    ↓
ArgoCD
    ↓
Amazon EKS
    ↓
3-Tier Employee Management Application

Observability Layer
────────────────────
Prometheus
Grafana
Loki
Promtail
Alertmanager
Slack
```

---

# ☁️ Infrastructure Design

The infrastructure is divided into two independent layers.

## Core Infrastructure

Located under:

```text
terraform/Infrastructure
```

### Provisioned Components

* VPC
* Public & Private Subnets
* NAT Gateway
* Route Tables
* Amazon EKS
* Managed Node Groups
* Amazon ECR
* Amazon RDS
* IAM Roles and Policies

---

## Cluster Bootstrap

Located under:

```text
terraform/Cluster-Bootstrap
```

### Provisioned Components

* Kubernetes Providers
* ArgoCD Installation
* GitOps Bootstrap
* Monitoring Bootstrap

### Benefits

* Modular Infrastructure
* Easier Maintenance
* Independent Lifecycle Management
* Production-Oriented Design

---

# 🧑‍💼 3-Tier Employee Management Application

The platform deploys a complete Employee Management System.

## Architecture

```text
Frontend
    ↓
Backend API
    ↓
MySQL Database
```

### Deployment Flow

```text
GitHub Actions
       ↓
Docker Build
       ↓
Amazon ECR
       ↓
GitOps Repository Update
       ↓
ArgoCD Sync
       ↓
Amazon EKS Deployment
```

---

# 🔄 CI/CD Pipeline

GitHub Actions automates:

* Docker Image Build
* ECR Authentication
* Image Push
* GitOps Manifest Updates
* Infrastructure Workflows

### Benefits

* Automated Delivery
* Repeatable Builds
* Reduced Manual Operations

---

# 🚀 GitOps Workflow

ArgoCD continuously watches Git repositories and synchronizes workloads into EKS.

### Managed Applications

* Employee Management Application
* Prometheus
* Loki
* Promtail

### Capabilities

* Automated Synchronization
* Self-Healing
* Drift Detection
* Git as Source of Truth

---

# 📊 Observability Stack

## Metrics Monitoring

```text
Node Exporter
      ↓
Prometheus
      ↓
Grafana
```

### Monitored Metrics

* CPU Usage
* Memory Usage
* Disk Utilization
* Network Utilization
* Kubernetes Health

---

## Centralized Logging

```text
Application Logs
      ↓
Promtail
      ↓
Loki
      ↓
Grafana
```

### Capabilities

* Centralized Logging
* Application Troubleshooting
* Cluster Log Analysis

---

## Alerting

```text
Prometheus
      ↓
Alertmanager
      ↓
Slack
```

### Implemented Alerts

* High CPU Usage
* Pod Restart Alerts
* Cluster Health Alerts
* Test Alerts

---

# 📂 Repository Structure

```text
.
├── .github/workflows/
│   ├── CI.yaml
│   ├── CD.yaml
│   └── infra-provision.yaml
│
├── docs/
│   ├── architecture/
│   └── screenshots/
│
├── gitops-k8s/
│   ├── apps/
│   ├── argocd/
│   ├── helm/
│   └── monitoring/
│       ├── prometheus.yaml
│       ├── loki.yaml
│       └── promtail.yaml
│
├── terraform/
│   ├── Infrastructure/
│   │   ├── VPC/
│   │   ├── EKS/
│   │   ├── ECR/
│   │   └── RDS/
│   │
│   └── Cluster-Bootstrap/
│       ├── argocd.tf
│       ├── provider.tf
│       └── terraform.tfstate.d/
│
└── README.md
```

---

# 🛠️ Challenges Faced

## Prometheus Operator CRD Issue

### Problem

```text
no matches for kind "Prometheus"
no matches for kind "Alertmanager"
```

### Root Cause

Missing Prometheus Operator CRDs.

### Resolution

* Installed Missing CRDs
* Restarted Prometheus Operator
* Verified Resource Reconciliation
* Successfully Created Prometheus and Alertmanager StatefulSets

### Learning

Understanding Kubernetes Operators and CRD lifecycle management is critical in production environments.

---

# 📚 Key Learnings

* Infrastructure as Code using Terraform
* Kubernetes Administration
* GitOps with ArgoCD
* Docker Containerization
* CI/CD Automation
* Kubernetes Monitoring
* Centralized Logging
* Alert Management
* Operator-Based Workloads
* Troubleshooting Kubernetes CRDs
* Production Incident Analysis

---

# 🔮 Future Improvements

* Horizontal Pod Autoscaler (HPA)
* Karpenter
* External Secrets Operator
* Multi-Environment GitOps
* OpenTelemetry
* Cost Monitoring
* SLO/SLI Dashboards

---

# 📖 Documentation

Additional documentation:

* `docs/prometheus-operations.md`
* `docs/monitoring-troubleshooting.md`
* `docs/gitops-workflow.md`
* `docs/deployment-guide.md`

---

# 💼 Resume Summary

Built an end-to-end Cloud Native DevOps Platform on AWS EKS using Terraform, GitHub Actions, Docker, Amazon ECR, ArgoCD, Prometheus, Grafana, Loki, Promtail, Alertmanager, and Slack to automate infrastructure provisioning, GitOps-based application deployment, monitoring, logging, and incident response workflows.

---

# 👨‍💻 Author

**Sunil Chouhan**

DevOps Engineer | Cloud Enthusiast | AWS & Kubernetes Learner
