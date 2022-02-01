# EKS cluster

module "eks_cluster" {
  source       = "git@github.com:akshaypandhare/eks-cluster.git"
  vpc_id       = "vpc-0b7964057d3eef07a"
  cluster_name = "testing-module"
  env_name     = "dev"
  aws_region   = "us-west-2"
  subnet_ids   = ["subnet-07a112b4bec0b8526", "subnet-019ad8f9ed243c0b7"]
}

# EKS nodegroup

module "node_group" {
  source          = "git@github.com:akshaypandhare/eks-node-group.git"
  cluster_name    = module.eks_cluster.eks_cluster_id
  node_group_name = "node-group"
  env_name        = "dev"
  aws_region      = "us-west-2"
  subnet_ids      = ["subnet-07a112b4bec0b8526", "subnet-019ad8f9ed243c0b7"]
}

# EKS cluster autoscaling and ELB controller.

data "aws_eks_cluster" "this" {
  name = module.eks_cluster.eks_cluster_id
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks_cluster.eks_cluster_id
}

provider "aws" {
    region = "us-west-2"
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  }
}

provider "kubernetes" {
  token                  = data.aws_eks_cluster_auth.this.token
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
}

module "scaling" {
  source                               = "git@github.com:akshaypandhare/autoscaler-and-ingress-controler.git"
  eks_cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  eks_cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn
  eks_cluster_id                       = module.eks_cluster.eks_cluster_id
  providers = {
    kubernetes.eks = kubernetes
    helm.eks       = helm
  }
}
