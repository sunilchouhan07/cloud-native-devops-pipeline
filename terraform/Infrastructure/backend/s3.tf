resource "aws_s3_bucket" "state_bucket" {
  bucket = "gitops-bucket-7"
  
  tags = {
    Name = "Backend"
  }
}