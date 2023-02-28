# create an IAM role that allows S3 write access
module "jenkins_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}

resource "aws_iam_role_policy_attachment" "jenkins_s3_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = module.jenkins_role.this_iam_role_name
}
