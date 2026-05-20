# data "aws_caller_identity" "current" {}
# resource "aws_iam_role" "image_updater" {
#   name = "argocd-image-updater-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = {
#         Federated = aws_iam_openid_connect_provider.eks_connect.arn
#       },
#       Action = "sts:AssumeRoleWithWebIdentity",
#       Condition = {
#         StringEquals = {
#           "${replace(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:argocd:argocd-image-updater"
#         }
#       }
#     }]
#   })
# }


# resource "aws_iam_role_policy" "image_updater_policy" {
#   role = aws_iam_role.image_updater.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Action = [
#         "ecr:GetAuthorizationToken",
#         "ecr:BatchGetImage",
#         "ecr:DescribeImages",
#         "ecr:ListImages",
#         "ecr:GetDownloadUrlForLayer",
#         "ecr:ListImages" 
#       ],
#       Resource = "*"
#     }]
#   })
# }

# # resource "kubernetes_service_account" "image_updater" {
# #   metadata {
# #     name      = "argocd-image-updater"
# #     namespace = "argocd"

# #     annotations = {
# #       "eks.amazonaws.com/role-arn" = aws_iam_role.image_updater.arn
# #     }
# #   }
# # }

