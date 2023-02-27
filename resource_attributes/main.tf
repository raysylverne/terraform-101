# create a local file with content passed random_pet resource attribute
# nothign hard coded all arguements passed using variable
resource "local_file" "pet" {
  filename = var.filename
  content = "My favorite pet is ${random_pet.my-pet.id}"
}

# generate a random pet name by importing the random provider
resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}