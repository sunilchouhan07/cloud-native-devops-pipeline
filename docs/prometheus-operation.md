# Prometheus Operations Guide

This document contains Prometheus architecture, operational commands, ArgoCD reconciliation procedures, troubleshooting steps, and commonly used PromQL queries used in this project.

---

# Overview

Prometheus is the primary monitoring solution used in this project.

It collects metrics from:

* Kubernetes Nodes
* Pods
* Deployments
* Services
* Applications
* Node Exporter
* kube-state-metrics

The collected metrics are stored as time-series data and visualized through Grafana dashboards.

---

# Monitoring Architecture

```text
Node Exporter
      ↓
Prometheus
      ↓
Grafana

Prometheus
      ↓
Alertmanager
      ↓
Slack
```

---

# Core Components

## Prometheus

Responsibilities:

* Metrics Collection
* Metrics Storage
* Alert Evaluation
* PromQL Query Processing

---

## Prometheus Operator

Responsibilities:

* Prometheus Resource Management
* Alertmanager Resource Management
* ServiceMonitor Management
* PrometheusRule Management
* Operator Reconciliation

---

## Node Exporter

Provides:

* CPU Metrics
* Memory Metrics
* Disk Metrics
* Network Metrics

---

## kube-state-metrics

Provides Kubernetes object metrics such as:

* Pods
* Deployments
* StatefulSets
* Nodes
* Namespaces

---

# Operational Commands

## Check Monitoring Pods

```bash
kubectl get pods -n monitoring
```

### Purpose

Verify all monitoring components are running correctly.

Expected Components:

* Prometheus
* Grafana
* Alertmanager
* Prometheus Operator
* Node Exporter
* kube-state-metrics
* Loki
* Promtail

---

## Check Prometheus Resource

```bash
kubectl get prometheus -A
```

### Purpose

Verify that Prometheus Custom Resource exists.

Expected:

```text
NAMESPACE    NAME
monitoring   prometheus-kube-prometheus-prometheus
```

---

## Check Alertmanager Resource

```bash
kubectl get alertmanager -A
```

### Purpose

Verify that Alertmanager Custom Resource exists.

Expected:

```text
NAMESPACE    NAME
monitoring   prometheus-kube-prometheus-alertmanager
```

---

## Check Operator Status

```bash
kubectl get deployment \
prometheus-kube-prometheus-operator \
-n monitoring
```

### Purpose

Verify Prometheus Operator is healthy.

---

## View Operator Logs

```bash
kubectl logs deployment/prometheus-kube-prometheus-operator \
-n monitoring
```

### Purpose

Used for troubleshooting:

* Missing CRDs
* Reconciliation Failures
* Permission Issues
* Configuration Problems

---

## Restart Prometheus Operator

```bash
kubectl rollout restart deployment \
prometheus-kube-prometheus-operator \
-n monitoring
```

### Purpose

Forces Prometheus Operator to reconcile resources again.

Used after:

* CRD installation
* Configuration changes
* Recovery procedures

---

# Verify Prometheus Operator CRDs

```bash
kubectl get crd | grep monitoring.coreos.com
```

Expected:

```text
alertmanagerconfigs.monitoring.coreos.com
alertmanagers.monitoring.coreos.com
podmonitors.monitoring.coreos.com
probes.monitoring.coreos.com
prometheusagents.monitoring.coreos.com
prometheuses.monitoring.coreos.com
prometheusrules.monitoring.coreos.com
scrapeconfigs.monitoring.coreos.com
servicemonitors.monitoring.coreos.com
thanosrulers.monitoring.coreos.com
```

### Why Important

Prometheus and Alertmanager resources cannot exist without these CRDs.

---

# Access Prometheus UI

```bash
kubectl port-forward \
svc/prometheus-kube-prometheus-prometheus \
-n monitoring \
9090:9090
```

Access:

```text
http://localhost:9090
```

Used for:

* PromQL Queries
* Alert Inspection
* Target Validation

---

# Access Grafana

```bash
kubectl port-forward \
svc/prometheus-grafana \
-n monitoring \
3000:80
```

Access:

```text
http://localhost:3000
```

Used for:

* Dashboards
* Metrics Visualization
* Logs Exploration
* Alert Monitoring

---

# ArgoCD Operations

## Check ArgoCD Applications

```bash
kubectl get apps -n argocd
```

Expected:

```text
NAME         SYNC STATUS   HEALTH STATUS
myapp        Synced        Healthy
prometheus   Synced        Healthy
loki         Synced        Healthy
promtail     Synced        Healthy
```

---

## Hard Refresh Application

```bash
kubectl annotate application prometheus \
-n argocd \
argocd.argoproj.io/refresh=hard \
--overwrite
```

### Purpose

Forces ArgoCD to refresh application state and re-evaluate all resources.

### Use Cases

* After installing CRDs
* After fixing Operator issues
* Resources not syncing
* Unexpected OutOfSync status

---

## Force Sync Application

```bash
kubectl patch application prometheus \
-n argocd \
--type merge \
-p '{"operation":{"initiatedBy":{"username":"admin"},"sync":{"syncStrategy":{"hook":{}}}}}'
```

### Purpose

Triggers a manual synchronization.

### Use Cases

* Resources not created
* Drift detected
* Manual reconciliation required

---

# Prometheus Operator CRD Recovery

## Symptoms

```text
No resources found
```

or

```text
no matches for kind "Prometheus"
```

or

```text
no matches for kind "Alertmanager"
```

---

## Root Cause

Prometheus Operator CRDs are missing.

---

## Resolution

Install Missing CRDs:

```bash
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusagents.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_scrapeconfigs.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.83.0/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
```

Restart Operator:

```bash
kubectl rollout restart deployment \
prometheus-kube-prometheus-operator \
-n monitoring
```

Hard Refresh ArgoCD:

```bash
kubectl annotate application prometheus \
-n argocd \
argocd.argoproj.io/refresh=hard \
--overwrite
```

Verify:

```bash
kubectl get prometheus -A

kubectl get alertmanager -A

kubectl get pods -n monitoring
```

Expected:

```text
prometheus-prometheus-kube-prometheus-prometheus-0
alertmanager-prometheus-kube-prometheus-alertmanager-0
```

---

# Common PromQL Queries

## Target Availability

```promql
up
```

Result:

```text
1 = Healthy
0 = Down
```

---

## Running Pods

```promql
count(kube_pod_status_phase{phase="Running"})
```

Returns total running pods.

---

## Node Count

```promql
count(kube_node_info)
```

Returns total Kubernetes worker nodes.

---

## Pod Restart Count

```promql
sum(kube_pod_container_status_restarts_total)
```

Identifies unstable workloads.

---

## Memory Usage

```promql
(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes)
```

Displays currently consumed memory.

---

## CPU Usage

```promql
100 - (
avg by(instance)
(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100
)
```

Displays CPU utilization percentage.

---

# Key Learnings

* Prometheus uses a pull-based monitoring model.
* Prometheus Operator depends on CRDs.
* ServiceMonitors control target discovery.
* PromQL is used for querying metrics.
* Alertmanager handles alert routing.
* Grafana provides visualization and troubleshooting.
* Missing CRDs can prevent Prometheus and Alertmanager creation.
* Understanding Operator reconciliation is critical in Kubernetes environments.
* ArgoCD Hard Refresh is useful when resources are not reconciled after dependency fixes.
