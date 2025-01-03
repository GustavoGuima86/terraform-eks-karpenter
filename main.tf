module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.27.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    # coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  self_managed_node_groups = {

    default_node_group = {
      create = false
    }

    spot-node-group = {
      name       = "spot-node-group"
      subnet_ids = module.vpc.private_subnets

      desired_size         = 1
      min_size             = 1
      max_size             = 2
      bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = 0
          on_demand_percentage_above_base_capacity = 0
          spot_allocation_strategy                 = "lowest-price" # "capacity-optimized" described here: https://aws.amazon.com/blogs/compute/introducing-the-capacity-optimized-allocation-strategy-for-amazon-ec2-spot-instances/
        }

        override = [
          {
            instance_type     = "t3.xlarge"
            weighted_capacity = "1"
          }
        ]
      }

    }

  }

  enable_cluster_creator_admin_permissions = true

  tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }

}