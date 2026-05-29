resource "helm_release" "argocd" {
  name             = "${var.env}-argocd"
  namespace        = var.namespace
  create_namespace = true 
  repository = var.repository
  chart      = var.chart
  version    = "7.7.11"


  values = [
    yamlencode({
      server = {
        service = {
          type = "LoadBalancer"
        }
      }
    })
  ]
}
