variable "region" {
  type = string
  default = "eu-central-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC"
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  default     = "eks-vpc"
  description = "The name of the VPC"
}

variable "cluster_name" {
  type = string
  description = "cluster name"
}