provider "aws" {
  region = var.aws_region
}

module "label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  name       = var.cluster_name
  stage      = var.env_name
  delimiter  = "-"
  attributes = ["cluster"]
}

module "eks_cluster" {
  source                            = "cloudposse/eks-cluster/aws"
  version                           = "0.45.0"
  vpc_id                            = var.vpc_id
  region                            = var.aws_region
  subnet_ids                        = var.subnet_ids
  oidc_provider_enabled             = true
  context                           = module.label.context
  cluster_encryption_config_enabled = false
  apply_config_map_aws_auth         = false
}
