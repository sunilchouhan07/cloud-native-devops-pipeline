resource "helm_release" "loki" {
  name       = "${var.env}-loki"
  namespace  = var.namespace
  repository = var.loki_repo
  chart      = var.loki_chart
  timeout = 300
  wait    = true
  values = [
    file("${path.module}/helm-values/loki-values.yaml")
  ]
  depends_on = [
    helm_release.prometheus_stack
  ]
}


resource "helm_release" "promtail" {
  name       = "${var.env}promtail"
  namespace  = var.namespace
  chart      = var.promtail_chart
  set {
    name  = "config.clients[0].url"
    value = "http://loki:3100/loki/api/v1/push"
  }
}

