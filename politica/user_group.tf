resource "aws_iam_user" "user" {
  name = var.user-name
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_group" "group" {
  name = var.group-name
}

resource "aws_iam_group_membership" "team" {
  name = var.time-name

  users = [
    aws_iam_user.user.name,
  ]

  group = aws_iam_group.group.name
}