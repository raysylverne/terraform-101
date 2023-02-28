resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data = var.user_data
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}