terraform {
  cloud {
    organization = "ziyotek_terraform"
    workspaces {
      name = "Ziyotek"
    }
  }
}

resource "aws_route53_zone" "GoGreen_com" {
  name = "GoGreen.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.GoGreen_com.zone_id
  name    = "www.GoGreen.com"
  type    = "A"
  ttl     = 300
  records = ["1.2.3.4"]  
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "us-west-1b"
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24" 
  availability_zone       = "us-west-1b"
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"  
  availability_zone       = "us-west-1c"
}

resource "aws_subnet" "subnet4" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.4.0/24"  
  availability_zone       = "us-west-1b"
}
