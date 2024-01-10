# Terraform Cloud Configuration
terraform {
  cloud {
    organization = "ziyotek_terraform"
    
    workspaces {
      name = "Ziyotek"
    }
  }
}

# AWS VPC Configuration
resource "aws_vpc" "my_vpc" {
  # Define a Virtual Private Cloud (VPC) with a specified CIDR block
  cidr_block = "10.0.0.0/16"
  
  # Enable DNS support and hostnames for the VPC
  enable_dns_support   = true
  enable_dns_hostnames = true

  # Tags for better identification of the resource
  tags = {
    Name        = "MyVPC"
    Environment = "Production"
  }
}

# AWS Route 53 Configuration
resource "aws_route53_zone" "GoGreen_com" {
  # Create a Route 53 hosted zone for the domain "GoGreen.com"
  name = "GoGreen.com"
}

resource "aws_route53_record" "www" {
  # Create a Route 53 record for the subdomain "www.GoGreen.com"
  zone_id = aws_route53_zone.GoGreen_com.zone_id
  name    = "www.GoGreen.com"
  type    = "A"
  ttl     = 300
  records = ["10.0.0.158"]
}

# AWS Subnet Configuration
resource "aws_subnet" "subnet1" {
  # Create a subnet within the specified VPC, with a specific CIDR block and availability zone
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "us-west-1b"

  # Tags for better identification of the resource
  tags = {
    Name        = "Subnet1"
    Environment = "Production"
  }
}

# AWS Internet Gateway
resource "aws_internet_gateway" "Production" {
  # Attach an internet gateway to the specified VPC
  vpc_id = aws_vpc.my_vpc.id

  # Tags for better identification of the resource
  tags = {
    Name        = "MyIGW"
    Environment = "Production"
  }
}

# AWS Route Table
resource "aws_route_table" "my_route_table" {
  # Create a route table and associate it with the specified VPC
  vpc_id = aws_vpc.my_vpc.id

  # Tags for better identification of the resource
  tags = {
    Name        = "MyRouteTable"
    Environment = "Production"
  }
}

# Associate the default route table with the first subnet
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}

# Security Group
resource "aws_security_group" "my_security_group" {
  # Create a security group allowing incoming traffic on port 80 (HTTP) from any IP address
  name        = "my-security-group"
  description = "My Security Group Description"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tags for better identification of the resource
  tags = {
    Name        = "MySecurityGroup"
    Environment = "Production"
  }
}

# Output the public IP address of the Route 53 record
output "www_record_ip" {
  value = aws_route53_record.www.records[0]
}