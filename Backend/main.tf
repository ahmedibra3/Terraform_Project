terraform {
  backend "s3" {
    bucket = "backend2terraform-project"
    region = "us-east-1"
    key = "dev/backend/state.tf"
    dynamodb_table = "terraform-backend"
    
  }
}
