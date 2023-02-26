terraform {
  /* Uncomment this block to use Terraform Cloud for this tutorial
	cloud {
			organization = "organization-name"
			workspaces {
				name = "learn-terraform-outputs"
			}
	}
	*/

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.43.0"
    }
  }
}