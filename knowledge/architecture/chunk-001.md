The **Mr. Beefy** system is built as a serverless, cost-efficient AI platform
running on AWS Bedrock. It uses a retrieval-augmented generation (RAG)
architecture backed by a GitHub wiki as the single source of truth.

## Core Components
- **AWS Bedrock Agent**  
  Orchestrates reasoning, tool use, and knowledge retrieval.

- **Knowledge Base (S3 Vector Store)**  
  Stores embeddings generated from structured wiki content.

- **GitHub Wiki**  
  Human-readable documentation and the authoritative source of all knowledge.

- **GitHub Action (Wiki → Knowledge Sync)**  
  Extracts wiki content, transforms it, and updates the `/knowledge` directory.

- **Lambda + API Gateway**  
  Provides a lightweight backend for the public-facing UI.

- **Static Frontend (S3 + CloudFront)**  
  A simple SPA that interacts with the Bedrock agent.

## Data Flow
1. Jordan updates the wiki.  
2. GitHub Action extracts structured content.  
3. Knowledge files are committed to `/knowledge`.  
4. A sync pipeline uploads knowledge to S3.  
5. Bedrock re-indexes the knowledge base.  
6. Users query the agent through the frontend.  
7. The agent retrieves relevant knowledge and responds.