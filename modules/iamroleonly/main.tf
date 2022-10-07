resource "aws_iam_role" "iamread" {
  name = "AWS_IAM_AAD_UpdateTask_CrossAccountRole"
  description = "Added common roles"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [var.account_id]
    }
  }
}

resource "aws_iam_role_policy" "allow_iam_read" {
  role   = aws_iam_role.iamread.id
  policy = data.aws_iam_policy_document.allow_readiam.json
}

data "aws_iam_policy_document" "allow_readiam" {
  statement {
    effect = "Allow"
    actions = [
                "iam:GenerateCredentialReport",
                "iam:GenerateServiceLastAccessedDetails",
                "iam:Get*",
                "iam:List*",
                "iam:SimulateCustomPolicy",
                "iam:SimulatePrincipalPolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_ssm_parameter" "networkacc" {
  name      = "/commonroles/networkaccd"
  type      = "String"
  value     = var.network_account_id
  overwrite = true
}

resource "aws_ssm_parameter" "iamacc" {
  name      = "commonroles/iamacc"
  type      = "String"
  value     = var.iam_account_id
  overwrite = true
}
