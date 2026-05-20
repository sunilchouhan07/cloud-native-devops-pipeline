module "argocd" {
  source     = "../modules/Helm/argocd"
  env        = local.env
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
}