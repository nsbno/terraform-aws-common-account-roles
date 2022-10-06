output "role_id_iamread" {
  value = aws_iam_role.iamread.id
}

output "role_arn_iamread" {
  value = aws_iam_role.iamread.arn
}

output "role_id_network" {
  value = aws_iam_role.network.id
}

output "role_arn_network" {
  value = aws_iam_role.network.arn
}
