resource "aws_iam_policy" "kafka_client_msk_policy" {
  name = "EKSKafkaClientMSKPolicy"
  path = "/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Effect: "Allow",
        Action: "kafka-cluster:*",
        Resource: [
            "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:group/*/*/*",
            "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:topic/*/*/*",
            "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/*/*",
            "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:transactional-id/*/*/*"
        ]
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:ListTagsForResource",
          "kafka:ListScramSecrets",
          "kafka:DescribeCluster",
          "kafka:GetBootstrapBrokers",
          "kafka:BatchDisassociateScramSecret",
          "kafka:RebootBroker",
          "kafka:BatchAssociateScramSecret",
          "kafka:ListNodes",
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/*/*"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:ListClusterOperations"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/clusters/*"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:ListClusters"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/clusters"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:ListKafkaVersion"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/kafka-versions"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:DescribeConfiguration"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/configurations/*"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:DescribeClusterOperation"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/operations/*"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:ListConfigurationRevisions"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/configurations/*/revisions"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:DescribeConfigurationRevision"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/configurations/*/revisions/*"
      },
      {
        Effect : "Allow",
        Action: [
          "kafka:GetCompatibleKafkaVersions"
        ],
        Resource : "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:/v1/compatible-kafka-versions"
      }
    ]
  })
}