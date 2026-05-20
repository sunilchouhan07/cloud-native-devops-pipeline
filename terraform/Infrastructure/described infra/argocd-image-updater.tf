# resource "helm_release" "image_updater" {
#   name       = "argocd-image-updater"
#   namespace  = "argocd"

#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argocd-image-updater"
#    values = [
#     <<EOF
# config:
#   registries:
#     - name: ECR
#       api_url: https://${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com
#       prefix: ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com
#       ping: yes
#   # Add this section to link your Git secret
#   git:
#     credentials:
#       secret: argocd/git-creds


# EOF
#   ]
# }


# # resource "kubernetes_secret" "git_creds" {
# #   metadata {
# #     name      = "git-creds"
# #     namespace = "argocd"
# #   }

# #   data = {
# #     username = (local.github_token)
# #     password = (local.github_token)
# #   }
# # }