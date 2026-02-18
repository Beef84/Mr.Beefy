param(
  [string]$BucketArn,
  [string]$KbRoleArn
)

# --- Knowledge Base Configuration ---
$kbConfig = @{
    type = "VECTOR"
    vectorKnowledgeBaseConfiguration = @{
        embeddingModelArn = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v2:0"
    }
} | ConvertTo-Json -Depth 5

# --- Storage Configuration ---
$storageConfig = @{
    type = "S3"
    s3Configuration = @{
        bucketArn = $BucketArn
    }
} | ConvertTo-Json -Depth 5

aws bedrock-agent create-knowledge-base `
  --name "mrbeefy-kb" `
  --role-arn $KbRoleArn `
  --knowledge-base-configuration "$kbConfig" `
  --storage-configuration "$storageConfig"