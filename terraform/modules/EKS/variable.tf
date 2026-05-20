variable "env" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type = string
}

variable "private_subnet_ids" {
    type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}