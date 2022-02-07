variable "cluster_name" {
  description = "Required"
  type        = string
}

variable "env_name" {
  description = "Required"
  type        = string
}

variable "vpc_id" {
  description = "Required"
  type        = string
}

variable "aws_region" {
  description = "Required"
  type        = string
}

variable "subnet_ids" {
  description = "Required"
  type        = list(string)
}

variable "map_additional_iam_roles" {
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
