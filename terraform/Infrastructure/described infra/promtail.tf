resource "helm_release" "promtail" {
  name       = "promtail"
  namespace  = "monitoring"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"

  set {
    name  = "config.clients[0].url"
    value = "http://loki:3100/loki/api/v1/push"
  }
}
