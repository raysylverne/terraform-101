#allows traffic on port 22 from your IP and traffic on port 8080.
module "jenkins_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name_prefix = "jenkins-server"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [var.ingress_cidr_blocks]
  ingress_rules       = [{ from_port = var.from_port, to_port = var.to_port, protocol = "tcp" }]

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}
