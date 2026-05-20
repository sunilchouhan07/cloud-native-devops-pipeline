resource "kubernetes_secret" "alertmanager_config" {
  metadata {
    name      = "alertmanager-custom-config"
    namespace = "monitoring"
  }
  data = {
    "alertmanager.yaml" = templatefile("${path.module}/monitoring-values/alertmanager.yaml", {
      webhook_url = var.slack_webhook_url
    })
  }

  type = "Opaque"
}

resource "helm_release" "prometheus_stack" {
  name       = "prometheus"
  namespace  = "monitoring"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [
    file("${path.module}/helm-values/prometheus-values.yaml")
  ]

  depends_on = [
    kubernetes_secret.alertmanager_config
  ]
}