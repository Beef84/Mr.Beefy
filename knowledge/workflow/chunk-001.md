## Documentation Flow
1. Jordan updates the GitHub wiki.  
2. A GitHub Action detects changes.  
3. The wiki is cloned and parsed.  
4. Structured content is generated into `/knowledge`.  
5. The knowledge directory is committed back to the main repo.  
6. A sync pipeline uploads the knowledge to S3.  
7. AWS Bedrock Knowledge Base re-indexes automatically.

## Request Flow
1. User interacts with the frontend.  
2. API Gateway receives the request.  
3. Lambda forwards the request to Bedrock Agent Runtime.  
4. The agent retrieves relevant knowledge.  
5. The model generates a response.  
6. The response is returned to the user.