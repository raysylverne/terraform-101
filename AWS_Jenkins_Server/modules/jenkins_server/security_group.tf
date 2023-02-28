#allows traffic on port 22 from your IP and traffic on port 8080.
module "jenkins_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name_prefix = "jenkins-server"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${var.my_ip}/32"]
  ingress_rules       = [{ from_port = 22, to_port = 22, protocol = "tcp" }, 
  { from_port = 8080, to_port = 8080, protocol = "tcp" }]

  tags = {
    Terraform   = "true"
    Environment = "jenkins"
  }
}
