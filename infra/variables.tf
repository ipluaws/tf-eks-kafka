variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "united"
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks of the public subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks of the private subnets"
  type        = list(string)
  default     = ["10.0.30.0/24", "10.0.40.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "producer"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "united"
}


