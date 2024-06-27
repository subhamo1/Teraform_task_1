# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "eks_cluster_vpc"
#   cidr = "10.0.0.0/16"

#   azs = data.aws_availability_zones.azs.names

#   #   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets = var.public_subnets
#   private_subnets= var.private_subnets

#   #   enable_nat_gateway = true
#   #   enable_vpn_gateway = true
#   enable_dns_hostnames    = true
#   enable_nat_gateway = true
#   single_nat_gateway = true


#   tags = {
#    "kubernetes.io/cluster/my-eks-cluster"="shared"
#   }
#   public_subnets_tags = {
#     "kubernetes.io/cluster/my-eks-cluster"="shared"
#     "kubernetes.iop/role/elb" =1
#   } 
#   private_subnets_tags = {
#     "kubernetes.io/cluster/my-eks-cluster": "shared",
#     "kubernetes.io/role/private_elb": =1
#   }
#   }


# # eks module 

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   cluster_name="my-eks-cluster"
#   cluster_version="1.29"
#   cluster_endpoint_public_acess=true
#   vpc_id=module.vpc.vpc_id
#   subnet_id=var.vpc.private_subnent_one
#   eks_managed_node_group={
#       min_size     = 1
#       max_size     = 3
#       desired_size = 2
#       instance_types=var.instance_types
#     }
#   }
#   tags{
#     Environment="dev"
#     Terraform="true"
#   }


# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "eks_cluster_vpc"
#   cidr = "10.0.0.0/16"

#   azs = data.aws_availability_zones.azs.names

#   # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = var.public_subnets
#   private_subnets = var.private_subnets

#   enable_dns_hostnames = true
#   enable_nat_gateway   = true
#   single_nat_gateway   = true

#   tags = {
#     "kubernetes.io/cluster/my-eks-cluster" = "shared"
#   }
#   public_subnet_tags = {
#     "kubernetes.io/cluster/my-eks-cluster" = "shared",
#     "kubernetes.io/role/elb"               = "1"
#   }
#   private_subnet_tags = {
#     "kubernetes.io/cluster/my-eks-cluster" = "shared",
#     "kubernetes.io/role/private_elb"       = "1"
#   }
# }

# # eks module 

# module "eks" {
#   source                         = "terraform-aws-modules/eks/aws"
#   cluster_name                   = "my-eks-cluster"
#   cluster_version                = "1.29"
#   cluster_endpoint_public_access = true
#   vpc_id                         = module.vpc.vpc_id
#   subnet_ids                     = var.private_subnets

#   eks_managed_node_group = {
#     min_size       = 1
#     max_size       = 3
#     desired_size   = 2
#     instance_types = var.instance_types
#   }


#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }



#Vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks_cluster_vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets


  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1

  }
  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/private_elb"       = 1

  }
}

#EKS

module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  cluster_name                   = "my-eks-cluster"
  cluster_version                = "1.29"
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = var.instance_types
    }
  }
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
