provider "aws" {
    region = "us-west-2"
}

resource "aws_eks_cluster" "this" {
  # enabled_cluster_log_types - (optional) is a type of set of string
  enabled_cluster_log_types = var.enabled_cluster_log_types
  # name - (required) is a type of string
  name = var.cluster_name
  # role_arn - (required) is a type of string
  role_arn = aws_iam_role.eks-master.arn
  # tags - (optional) is a type of map of string
  tags = var.tags
  # version - (optional) is a type of string
  version = var.cluster_version

  dynamic "encryption_config" {
    for_each = var.encryption_config
    content {
      # resources - (required) is a type of set of string
      resources = encryption_config.value["resources"]

      dynamic "provider" {
        for_each = encryption_config.value.provider
        content {
          # key_arn - (required) is a type of string
          key_arn = provider.value["key_arn"]
        }
      }

    }
  }

  dynamic "kubernetes_network_config" {
    for_each = var.kubernetes_network_config
    content {
      # service_ipv4_cidr - (optional) is a type of string
      service_ipv4_cidr = kubernetes_network_config.value["service_ipv4_cidr"]
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts
    content {
      # create - (optional) is a type of string
      create = timeouts.value["create"]
      # delete - (optional) is a type of string
      delete = timeouts.value["delete"]
      # update - (optional) is a type of string
      update = timeouts.value["update"]
    }
  }

  vpc_config {
      endpoint_private_access = var.endpoint_private_access 
      endpoint_public_access = var.endpoint_public_access
      public_access_cidrs  = var.public_access_cidrs 
      security_group_ids = [aws_security_group.eks-master.id]
      subnet_ids = var.subnet_ids
  }

  #dynamic "vpc_config" {
  #  for_each = var.vpc_config
  #  content {
  #    # endpoint_private_access - (optional) is a type of bool
  #    endpoint_private_access = vpc_config.value["endpoint_private_access"]
  #    # endpoint_public_access - (optional) is a type of bool
  #    endpoint_public_access = vpc_config.value["endpoint_public_access"]
  #    # public_access_cidrs - (optional) is a type of set of string
  #    public_access_cidrs = vpc_config.value["public_access_cidrs"]
  #    # security_group_ids - (optional) is a type of set of string
  ###    security_group_ids = vpc_config.value["security_group_ids"]
     # # subnet_ids - (required) is a type of set of string
  #    subnet_ids = vpc_config.value["subnet_ids"]
  ## }
  #}

}

## EKS cluster IAM role.

resource "aws_iam_role" "eks-master" {
  name = "${var.cluster_name}-eks-master"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "eks-master-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-master.name
}

resource "aws_iam_role_policy_attachment" "eks-master-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-master.name
}


## EKS cluster Security group.

resource "aws_security_group" "eks-master" {
  name        = "${var.cluster_name}-eks-master"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_protocols
    content {
      from_port = ingress.value["from_port"]
      to_port = ingress.value["to_port"]
      protocol = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_block"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-eks-master"
  }
}