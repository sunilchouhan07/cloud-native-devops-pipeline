resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  tags = {
    Name = "${var.env}-vpc"
    Environment = var.env 
  }
}





resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
    Environment = var.env 
  }
}




resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.main.id
  for_each = var.public_subnets
  cidr_block = each.value.cidr
  availability_zone       = each.value.az 
  map_public_ip_on_launch = true 
  tags = {
    Name = "${var.env}-${each.key}"
    Environment = var.env 
  }
}


resource "aws_subnet" "private_subnets" {
  vpc_id                  = aws_vpc.main.id
  for_each = var.private_subnets
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az 
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}-${each.key}"
    Environment = var.env 
  }
}


resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.env}-nat-eip"
    Environment = var.env 
  }
}





resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[var.nat_subnet_name].id 

  tags = {
    Name = "${var.env}-ngw"
    Environment = var.env 
  }
}





resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-pub-rt"
    Environment = var.env 
  }
}




resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}



resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.env}-pri-rt"
    Environment = var.env 
  }
}




resource "aws_route_table_association" "private_assoc" {
    for_each = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}



