output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.eks.id
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.eks.arn
}

output "node_group_arn" {
  description = "The ARN of the EKS node group"
  value       = aws_eks_node_group.node_group.arn
}

output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

