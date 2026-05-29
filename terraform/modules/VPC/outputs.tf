output "private_subnet_ids" {
  value = values(aws_subnet.private_subnets)[*].id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnets)[*].id
  
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "id" {
  value = aws_vpc.main.id
}