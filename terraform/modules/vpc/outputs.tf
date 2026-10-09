output "vpc_id" {
  description = "ID of the VPC created for the environment."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR range of the VPC."
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the internet gateway attached to the VPC."
  value       = aws_internet_gateway.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets used for load balancers and NAT."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets used for ECS tasks."
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "IDs of the isolated database subnets."
  value       = aws_subnet.database[*].id
}

output "database_subnet_group_name" {
  description = "Name of the database subnet group if database subnets are configured."
  value       = length(aws_db_subnet_group.this) > 0 ? aws_db_subnet_group.this[0].name : null
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs created for internet egress from private subnets."
  value       = aws_nat_gateway.this[*].id
}

output "public_route_table_id" {
  description = "The route table ID for public subnets."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "The route table IDs for private subnets."
  value       = aws_route_table.private[*].id
}
