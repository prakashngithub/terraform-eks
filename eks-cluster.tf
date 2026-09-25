module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "21.0"
  name    = local.cluster_name
  kubernetes_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets

  enable_irsa = true

  tags = {
    cluster = "demo"
  }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    ami_type               = "AL2023_x86_64_STANDARD"
    instance_types         = ["t2.xlarge"]
    vpc_security_group_ids = aws_security_group.all_worker_mgmt.id
    node_group = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
    }
  }


}

