resource "aws_vpc_peering_connection" "msk_eks" {
  peer_vpc_id = aws_vpc.vpc.id
  vpc_id      = var.eks_vpc_id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
