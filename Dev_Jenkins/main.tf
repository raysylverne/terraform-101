module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "jenkins-server"
  instance_count         = 1
  ami                    = "ami-0c94855ba95c71c99" # Amazon Linux 2
  instance_type          = "t2.micro"
  subnet_ids             = module.vpc.public_subnets
  vpc_security_group_ids = [module.jenkins_security_group.this_security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y java-openjdk11
              wget -O /etc/yum.repos.d/jenkins.repo <https://pkg.jenkins.io/redhat-stable/jenkins.repo>
              rpm --import <https://pkg.jenkins.io/redhat-stable/jenkins.io.key>
              yum upgrade -y
              yum install -y jenkins
              systemctl daemon-reload
              systemctl enable jenkins
              systemctl start jenkins
              EOF

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}

module "jenkins_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name_prefix = "jenkins-server"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${var.my_ip}/32"]
  ingress_rules       = [{ from_port = 22, to_port = 22, protocol = "tcp" }, { from_port = 8080, to_port = 8080, protocol = "tcp" }]

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}

module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket_name = "jenkins-artifacts-${random_id.random_id.hex}"
  acl         = "private"

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}

module "jenkins_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  name_prefix = "jenkins"
  policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  description = "IAM role for Jenkins Server"

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}

resource "aws_iam_role_policy_attachment" "jenkins_s3_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = module.jenkins_role.this_iam_role_name
}

