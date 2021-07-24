output "zookeeper_connect_string_scram" {
  description = "Apache ZooKeeper connection SCRAM"
  value       = aws_msk_cluster.msk_cluster_scram.zookeeper_connect_string
}

output "bootstrap_brokers_sasl_scram" {
  description = "SASL SCRAM connection host:port pairs"
  value       = aws_msk_cluster.msk_cluster_scram.bootstrap_brokers_sasl_scram
}
