variable "region" {
  default = "us-east-1"
}

variable "cluster_name_scram" {
  default = "demo-msk-cluster-scram"
}

variable "eks_namespace" {
  default = "kafka"
}

variable "eks_vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "eks_vpc_id" {
  default = "vpc-07ddb9f63255a6422"
}