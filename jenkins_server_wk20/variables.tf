# This file references the resources and sets the necessary variables.
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_tag" {
  default = "my-vpc"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_tag" {
  default = "my-subnet"
}

variable "internet_gateway_tag" {
  default = "my-igw"
}

variable "ec2_role_name" {
  default = "ec2_role"
}

variable "ec2_instance_profile_name" {
  default = "ec2_instance_profile"
}

variable "ec2_role_policy_name" {
  default = "ec2_role_policy"
}

variable "ec2-trust-policy" {
  default = "trust-policy.json"
}

variable "ec2-s3-permissions" {
  default = "s3-permissions.json"
}

variable "bucket_name" {
  default = "rayblackteam"
}

variable "security_group_name" {
  default = "my-security-group"
}

variable "ami" {
  default = "ami-0dfcb1ef8550277af"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_key_name" {
  default = "cli-dev-proj"
}

variable "ec2_user_data" {
  default = "#!/bin/bash\\n\\nyum update -y\\nyum install -y java-1.8.0-openjdk\\nyum install -y wget\\nwget -O /etc/yum.repos.d/jenkins.repo <https://pkg.jenkins.io/redhat-stable/jenkins.repo\\nrpm> --import <https://pkg.jenkins.io/redhat-stable/jenkins.io.key\\nyum> install -y jenkins\\nsystemctl start jenkins\\nsystemctl enable jenkins\\n"
}

variable "ec2_tag" {
  default = "jenkins-server"
}
