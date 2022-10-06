resource "aws_iam_role" "iamread" {
  name = "AWS_IAM_AAD_UpdateTask_CrossAccountRole"
  description = "Added common roles"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role" "network" {
  name = "NetworkingAccountAccess"
  description = "Allows the common networking account to tag resources it shared with us"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

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

resource "aws_iam_role_policy" "allow_tagging" {
  role   = aws_iam_role.network.id
  policy = data.aws_iam_policy_document.allow_tagging.json
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

data "aws_iam_policy_document" "allow_tagging" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeSubnets",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeTags",
    ]
    resources = ["*"]
  }
}