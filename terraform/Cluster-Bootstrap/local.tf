locals {
  env = terraform.workspace
}

locals {
  allowed_workspaces = ["dev", "stg", "prod"]
}

resource "null_resource" "workspace_check" {

  lifecycle {
    precondition {
      condition     = contains(local.allowed_workspaces, terraform.workspace)
      error_message = "Invalid workspace! Use only dev, stg, or prod."
    }
  }
}