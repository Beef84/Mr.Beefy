## AWS Bedrock as the AI Platform
Chosen for its managed model hosting, agent orchestration, and integrated
Knowledge Bases.

## Serverless Architecture
Lambda, API Gateway, and S3 provide low-cost, scalable infrastructure suitable
for a public-facing agent.

## GitHub Wiki as the Single Source of Truth
Jordan writes documentation once. A GitHub Action extracts structured content
and updates the `/knowledge` directory automatically.

## S3 Vector Store
Provides low-cost, serverless vector storage for RAG workflows.

## Small Foundation Models
Models such as Claude 3 Haiku and Llama 3.1 8B provide fast, cost-efficient
inference suitable for public access.

## Documentation-Driven Engineering
All architecture, decisions, and workflows are documented in the wiki before
implementation.