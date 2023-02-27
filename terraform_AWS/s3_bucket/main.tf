#create s3 bucket 
resource "aws_s3_bucket" "HR" {
  bucket = "HR_Resumes-rjs022722"

  tags = {
    Name        = "Human Resources Dept"
  }
}

# upload a file into bucket we just created. All arguments shown are required. 
resource "aws_s3_bucket_object" "Ray_DevOpsEngineer" {
  bucket = aws_s3_bucket.HR.id
  key    = "Ray_DevOpsEngineer.pdf"
  source = "/Users/raysylver/Desktop/Ray_DevOpsEngineer.pdf"
}

data "aws_iam_group" "HR" {
    group_name = "HumanResources"
}

#create bucket policy 
resource "aws_s3_bucket_policy" "HR-Policy" {
    bucket = aws_s3_bucket.HR.id
}