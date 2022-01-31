module "eks_cluster" {
  source       = "../"
  vpc_id       = "vpc-0b7964057d3eef07a"
  cluster_name = "testing-module"
  env_name     = "dev"
  aws_region   = "us-west-2"
  subnet_ids   = ["subnet-07a112b4bec0b8526", "subnet-019ad8f9ed243c0b7"]
}
