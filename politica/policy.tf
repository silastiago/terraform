resource "aws_iam_policy" "my_developer_policy" {
  name  = "my_developer_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  policy_arn = aws_iam_policy.my_developer_policy.arn
  group      = aws_iam_group.group.name
}