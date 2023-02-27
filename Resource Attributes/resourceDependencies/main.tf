#Creates a PEM (and OpenSSH) formatted private RSA key of size 4096 bits
resource "tls_private_key" "pvtkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#use a reference expression to use the private_key_pem attribute of the pvtkey resource
resource "local_file" "key_details" {
  filename = var.filename
  content  = tls_private_key.pvtkey.private_key_pem
}