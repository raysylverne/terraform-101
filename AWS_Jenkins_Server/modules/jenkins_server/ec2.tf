/*Deploy an EC2 instance running Amazon Linux 2 and install and start 
Jenkins using the provided user data script.*/
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
