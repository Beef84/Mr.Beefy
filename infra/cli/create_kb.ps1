param(
  [string]$BucketArn,
  [string]$KbRoleArn
)

aws bedrock-agent create-knowledge-base `
  --name "mrbeefy-kb" `
  --role-arn $KbRoleArn `
  --knowledge-base-configuration '{
      "type": "VECTOR",
      "vectorKnowledgeBaseConfiguration": {
          "embeddingModelArn": "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v2:0"
      }
  }' `
  --storage-configuration "{
      \"type\": \"S3\",
      \"s3Configuration\": {
          \"bucketArn\": \"$BucketArn\"
      }
  }"