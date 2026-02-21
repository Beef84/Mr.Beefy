output "knowledge_bucket" {
  value       = aws_s3_bucket.knowledge.bucket
  description = "S3 bucket name used for knowledge files"
}

output "knowledge_bucket_arn" {
  value       = aws_s3_bucket.knowledge.arn
  description = "S3 bucket ARN used in IAM policies"
}

output "kb_role_arn" {
  value       = aws_iam_role.kb_role.arn
  description = "IAM role ARN used by the knowledge base ingestion service"
}

output "agent_id" {
  value       = aws_bedrockagent_agent.mrbeefy.id
  description = "Bedrock Agent id (DRAFT agent created by Terraform)"
}

# Alias is now created/updated by CI, not Terraform.
# Terraform cannot output a value it does not manage.
output "agent_alias_id" {
  value       = ""
  description = "Alias id (managed by CI/CD pipeline)"
}

output "api_url" {
  value       = format("%s/prod/chat", aws_apigatewayv2_api.http_api.api_endpoint)
  description = "HTTP API endpoint for the chat route"
}