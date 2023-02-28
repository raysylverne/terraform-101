#  S3 bucket with a unique name and ACL set to private.
module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "jenkins-artifacts-${random_id.random_id.hex}"
  acl    = "private"

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}