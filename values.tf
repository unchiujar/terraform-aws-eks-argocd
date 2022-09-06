locals {
  values = yamlencode({
    "controller" : {
      "serviceAccount" : {
        "annotations" : {
          "eks.amazonaws.com/role-arn" : local.irsa_role_create ? aws_iam_role.this[0].arn : ""
        }
      }
    }
    "server" : {
      "serviceAccount" : {
        "annotations" : {
          "eks.amazonaws.com/role-arn" : local.irsa_role_create ? aws_iam_role.this[0].arn : ""
        }
      }
    }
  })
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values,
    var.values
  ])
}
