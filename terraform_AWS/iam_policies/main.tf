# create and admin iam user named IaC AdminUser
resource "aws_iam_user" "admin-user" {
  name = "Phillip"
  tags = {
    Description = "Infrastructure Team Member"
  }
}

# Create aws admin policy. Pass JSON policy using file func as an argument OR
# Or you can add hardcode json policy right into the config file like below
resource "aws_iam_policy" "adminUser" {
  name   = "AdminUsers"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
  })
  #policy = file("admin-policy.json")
}

# attaches policy you just created to user passing dependencies as argument variables for user and policy
resource "aws_iam_user_policy_attachment" "IaC_AdminUser_Access" {
  user       = aws_iam_user.admin-user.name
  policy_arn = aws_iam_policy.adminUser.arn

}