variable "cluster_name" {
  description = "The name of the EKS cluster"
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created"
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster will be created"
  type        = list(string)
}

