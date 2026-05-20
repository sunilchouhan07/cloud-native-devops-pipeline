resource "kubernetes_secret" "alertmanager_config" {
  metadata {
    name      = "alertmanager-custom-config"
    namespace = var.namespace
  }
  # data = {
  #   "alertmanager.yaml" = templatefile("${path.module}/helm-values/alertmanager.yaml", {
  #     webhook_url = var.slack_webhook_url
  #   })
  # }

  type = "Opaque"
}

resource "helm_release" "prometheus_stack" {
  name       = "${var.env}-prometheus"
  namespace  = var.namespace

  repository = var.prometheus_repo
  chart      = var.prometheus_chart
  values = [
    file("${path.module}/helm-values/prometheus-values.yaml")
  ]

  depends_on = [
    kubernetes_secret.alertmanager_config
  ]
}