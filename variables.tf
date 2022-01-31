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
