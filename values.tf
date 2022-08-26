locals {
  values_irsa = yamlencode({
    "controller" : {
        "serviceAccount" : {
          "annotations" : {
            "eks.amazonaws.com/role-arn" : aws_iam_role.this.arn
          }
        }
      }
    "server": {
      "serviceAccount" : {
          "annotations" : {
            "eks.amazonaws.com/role-arn" : aws_iam_role.this.arn
          }
        }
    }
  })
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    var.irsa_role_create ? local.values_irsa : yamlencode({}),
    var.values
  ])
}
