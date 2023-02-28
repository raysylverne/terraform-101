variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "EC2 instance image id"
  type        = string
  default     = "ami-0dfcb1ef8550277af"
}

variable "ec2_tags" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "jenkins"
    Name        = "jenkins-server"
  }
}

variable "user_data" {
  description = "User data script to bootstrap the EC2 instance"
  type        = string
  default     = <<-EOF
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
}

variable "from_port" {
  description = "From port for ingress traffic"
  type        = number
  default     = 22
}

variable "to_port" {
  description = "To port for ingress traffic"
  type        = number
  default     = 8080
}

variable "my_ip" {
  description = "Your public IP address"
  type        = string
}