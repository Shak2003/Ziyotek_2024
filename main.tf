# Terraform Cloud Configuration
terraform {
  cloud {
    # Specify the Terraform Cloud organization
    organization = "ziyotek_terraform"
    
    # Define the workspace where this configuration will be applied
    workspaces {
      name = "Ziyotek"
    }
  }
}

# AWS Route 53 Configuration
resource "aws_route53_zone" "GoGreen_com" {
  # Create a Route 53 hosted zone for the domain "GoGreen.com"
  name = "GoGreen.com"
}

resource "aws_route53_record" "www" {
  # Create an A record for the subdomain "www.GoGreen.com" within the hosted zone
  zone_id = aws_route53_zone.GoGreen_com.zone_id
  name    = "www.GoGreen.com"
  type    = "A"
  ttl     = 300
  records = ["10.0.0.158"]
}

# AWS VPC Configuration
resource "aws_vpc" "my_vpc" {
  # Create an AWS Virtual Private Cloud (VPC) with the CIDR block "10.0.0.0/16"
  cidr_block = "10.0.0.0/16"  
}

# AWS Subnet Configuration
resource "aws_subnet" "subnet1" {
  # Create a subnet within the VPC with CIDR block "10.0.1.0/24" in availability zone "us-west-1b"
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "us-west-1b"
}

resource "aws_subnet" "subnet2" {
  # Create another subnet within the VPC with CIDR block "10.0.2.0/24" in availability zone "us-west-1b"
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24" 
  availability_zone       = "us-west-1b"
}

resource "aws_subnet" "subnet3" {
  # Create a subnet within the VPC with CIDR block "10.0.3.0/24" in availability zone "us-west-1c"
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"  
  availability_zone       = "us-west-1c"
}

resource "aws_subnet" "subnet4" {
  # Create another subnet within the VPC with CIDR block "10.0.4.0/24" in availability zone "us-west-1b"
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.4.0/24"  
  availability_zone       = "us-west-1b"
}
