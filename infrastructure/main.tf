resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}
#Create VPC
#Create 3 subnets in different availability zones
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = true
}
#Create Internet Gateway and Route Table
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" #For public access to the internet
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  route {
    cidr_block = "10.0.0.0/16" #For private access within the VPC 
    gateway_id = "local"    
  }
}
 resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table.id 
 }

resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_3_association" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.route_table.id
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 19.0"

  cluster_name    = "qr-code-generator"
  cluster_version = "1.35"

  cluster_endpoint_public_access = true #Allow public access to the EKS cluster endpoint

  vpc_id          = aws_vpc.main.id
  subnet_ids      = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]
  control_plane_subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]

  eks_managed_node_groups = {
    green = {
      min_size = 1
      max_size = 1
      desired_size = 1
      instance_type = "t3.medium"
    }
  }
}

#terraform init  in directory containing the .tf files to initialize the configuration and download provider plugins and modules
#terraform plan to see the execution plan and verify the resources that will be created or modified
#terraform apply to create the resources defined in the configuration files.
#aws eks update-kubeconfig --region us-east-1 --name qr-code-generator  to configure kubectl to connect to the EKS cluster.
#kubectl get nodes  to verify that the EKS cluster is up and running and the worker nodes are registered with the cluster.
#kubectl cluster-info  to get the cluster information and verify that the Kubernetes API server is accessible.
#kubectl get pods --all-namespaces  to check the status of the pods running in the cluster, empty at this time.
