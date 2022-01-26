sg_protocols = [
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
    },
    {
      from_port = 33
      to_port = 33
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
  ]

vpc_id = "vpc-05e86e85b85315ac6"
subnet_ids = ["subnet-084660f50eb9fbec1", "subnet-03e21851db757a22f"]
cluster_name = "assaya-poc"
  
