output "arn" {
  description = "returns a string"
  value       = aws_eks_cluster.this.arn
}

output "cluster_name" {
  description = "returns a string"
  value       = aws_eks_cluster.this.name
}

output "certificate_authority" {
  description = "returns a list of object"
  value       = aws_eks_cluster.this.certificate_authority
}

output "created_at" {
  description = "returns a string"
  value       = aws_eks_cluster.this.created_at
}

output "endpoint" {
  description = "returns a string"
  value       = aws_eks_cluster.this.endpoint
}

output "id" {
  description = "returns a string"
  value       = aws_eks_cluster.this.id
}

output "eks_cluster_identity_oidc_issuer" {
  description = "The OIDC Identity issuer for the cluster"
  value       = aws_eks_cluster.this.identity.0.oidc.0.issuer
}

output "eks_cluster_identity_oidc_issuer_arn" {
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account"
  value       = aws_iam_openid_connect_provider.default.arn
}

output "identity" {
  description = "returns a list of object"
  value       = aws_eks_cluster.this.identity
}

output "platform_version" {
  description = "returns a string"
  value       = aws_eks_cluster.this.platform_version
}

output "status" {
  description = "returns a string"
  value       = aws_eks_cluster.this.status
}

output "version" {
  description = "returns a string"
  value       = aws_eks_cluster.this.version
}

output "this" {
  value = aws_eks_cluster.this
}
