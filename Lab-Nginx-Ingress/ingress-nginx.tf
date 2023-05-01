# You MUST have an EKS cluster already existing to run ingress Nginx on it
module "public_eks_cluster" {
  source         = "git::https://github.com/ghfaha/public_eks_cluster"
  vpc_name       = "k8s-cluster-VPC"
  cluster_name   = "k8s-cluster"
  desired_size   = 3
  max_size       = 5
  min_size       = 2
  instance_types = ["t2.micro"]
}
module "ingress-nginx" {
  # note update the source link with the required version
  source     = "git::https://github.com/ghfaha/nginx-ingress-controller-K8s"
  cluster_id = module.public_eks_cluster.id


}
output "k8s_service_ingress_elb" {
  value=module.ingress-nginx.k8s_service_ingress_elb
}