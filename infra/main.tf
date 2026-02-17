terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

# Knowledge S3 bucket
resource "aws_s3_bucket" "knowledge" {
  bucket = "mrbeefy-knowledge-${random_id.suffix.hex}"
}

# IAM role for KB (used by CLI-created KB)
resource "aws_iam_role" "kb_role" {
  name = "mrbeefy-kb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "bedrock.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "kb_policy" {
  role = aws_iam_role.kb_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.knowledge.arn,
          "${aws_s3_bucket.knowledge.arn}/*"
        ]
      }
    ]
  })
}

# Agent execution role
resource "aws_iam_role" "agent_role" {
  name = "mrbeefy-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "bedrock.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Bedrock Agent
resource "aws_bedrockagent_agent" "mrbeefy" {
  agent_name              = "mrbeefy-agent"
  foundation_model        = "anthropic.claude-3-5-sonnet-20240620-v1:0"
  agent_resource_role_arn = aws_iam_role.agent_role.arn

  instruction = <<EOF
You are Mr. Beefy, an AI agent engineered by Jordan Oberrath.
You use your knowledge base as the primary source of truth.
You explain the architecture clearly.
You never fabricate details.
EOF
}

# Agent alias
resource "aws_bedrockagent_agent_alias" "mrbeefy_prod" {
  agent_id         = aws_bedrockagent_agent.mrbeefy.id
  agent_alias_name = "prod"
}

# Lambda role
resource "aws_iam_role" "lambda_role" {
  name = "mrbeefy-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "bedrock-agent-runtime:InvokeAgent"
        ]
        Resource = "*"
      }
    ]
  })
}

# Lambda function (Node 20)
resource "aws_lambda_function" "api" {
  function_name = "mrbeefy-api"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  filename         = "${path.module}/lambda/dist.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/dist.zip")

  environment {
    variables = {
      AGENT_ID       = aws_bedrockagent_agent.mrbeefy.id
      AGENT_ALIAS_ID = aws_bedrockagent_agent_alias.mrbeefy_prod.id
      AWS_REGION     = "us-east-1"
    }
  }
}

# HTTP API Gateway
resource "aws_apigatewayv2_api" "http_api" {
  name          = "mrbeefy-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.api.arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "post_chat" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /chat"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "prod"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}