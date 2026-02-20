output "knowledge_bucket" {
  value = aws_s3_bucket.knowledge.bucket
}

output "kb_role_arn" {
  value = aws_iam_role.kb_role.arn
}

output "agent_id" {
  value = aws_bedrockagent_agent.mrbeefy.id
}

output "agent_alias_id" {
  value       = length(aws_bedrockagent_agent_alias.mrbeefy_prod) > 0 ? aws_bedrockagent_agent_alias.mrbeefy_prod[0].id : ""
  description = "Alias id (empty if alias not created yet)"
}

output "api_url" {
  value = "${aws_apigatewayv2_api.http_api.api_endpoint}/prod/chat"
}