# create and admin iam user named IaC AdminUser
resource "aws_iam_user" "admin-user" {
  name = "Phillip"
  tags = {
    Description = "Infrastructure Team Member"
  }
}

# Create aws admin policy. Pass JSON policy using file func 
resource "aws_iam_policy" "adminUser" {
  name   = "AdminUsers"
  policy = file("admin-policy.json")
}

# attaches policy you just created to user passing dependencies as argument variables for user and policy
resource "aws_iam_user_policy_attachment" "IaC_AdminUser_Access" {
  user       = aws_iam_user.admin-user.name
  policy_arn = aws_iam_policy.adminUser.arn

}