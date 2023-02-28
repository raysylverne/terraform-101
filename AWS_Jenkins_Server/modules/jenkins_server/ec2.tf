# Deploy ec2 instance running AmazonLinux2 + install & start Jenkins using the user data script
module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "jenkins-server"
  ami                    = var.ami # Amazon Linux 2
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets
  vpc_security_group_ids = [module.jenkins_security_group.this_security_group_id]

  user_data = var.user_data

  tags = var.ec2_tags
}