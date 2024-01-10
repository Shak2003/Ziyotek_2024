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
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name        = "MyVPC"
    Environment = "Production"
  }
}

# AWS Route 53 Configuration
resource "aws_route53_zone" "GoGreen_com" {
  name = "GoGreen.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.GoGreen_com.zone_id
  name    = "www.GoGreen.com"
  type    = "A"
  ttl     = 300
  records = ["10.0.0.158"]
}

# AWS Subnet Configuration
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "us-west-1b"

  tags = {
    Name        = "Subnet1"
    Environment = "Production"
  }
}

# AWS Internet Gateway
resource "aws_internet_gateway" "Production" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name        = "MyIGW"
    Environment = "Production"
  }
}

# AWS Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

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
  name        = "my-security-group"
  description = "My Security Group Description"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "MySecurityGroup"
    Environment = "Production"
  }
}

# Output the public IP address of the Route 53 record
output "www_record_ip" {
  value = aws_route53_record.www.records[0]
}


# Associate the default route table with the first subnet
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "My Security Group Description"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySecurityGroup"
    Environment = "Production"
  }
}

# Output the public IP address of the Route 53 record
output "www_record_ip" {
  value = aws_route53_record.www.records[0]
}

