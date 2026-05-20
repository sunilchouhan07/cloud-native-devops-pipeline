resource "helm_release" "loki" {
  name       = "loki"
  namespace  = "monitoring"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"

  timeout = 300
  wait    = true

  values = [
    file("${path.module}/helm-values/loki-values.yaml")
  ]

  depends_on = [
    helm_release.prometheus_stack
  ]
}

