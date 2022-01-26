variable "sg_protocols" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_block = list(string)
  }))

  default = [
    {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    },
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
  ]
}

variable "enabled_cluster_log_types" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "vpc_id" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "endpoint_private_access" {
  description = "(optional)"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "(optional)"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "subnet_ids" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "cluster_name" {
  description = "(required)"
  type        = string
}

variable "tags" {
  description = "(optional)"
  type        = map(string)
  default     = null
}

variable "cluster_version" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "encryption_config" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      provider = list(object(
        {
          key_arn = string
        }
      ))
      resources = set(string)
    }
  ))
  default = []
}

variable "kubernetes_network_config" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      service_ipv4_cidr = string
    }
  ))
  default = []
}

variable "timeouts" {
  description = "nested block: NestingSingle, min items: 0, max items: 0"
  type = set(object(
    {
      create = string
      delete = string
      update = string
    }
  ))
  default = []
}