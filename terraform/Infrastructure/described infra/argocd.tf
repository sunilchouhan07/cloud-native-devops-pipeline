resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "9.4.7"


  values = [
    yamlencode({
      server = {
        service = {
          type = "LoadBalancer"
        }
      }

      configs = {
        secret = {
          argocdServerAdminPassword = ""

        }
      }
    })
  ]

  depends_on = [
    aws_eks_node_group.nodes
  ]
}