CI/CD owns all dynamic, stateful, or versioned operations:

- Building and deploying Lambda code  
- Uploading Knowledge Base files  
- Starting Knowledge Base ingestion jobs  
- Associating the KB with the agent  
- Creating the agent alias if missing  
- Updating Lambda environment variables with alias IDs  
- Invalidating CloudFront cache  

CI/CD is the **single source of truth** for runtime configuration and agent lifecycle.

---

## **2.3 Runtime Ownership (AWS Services)**

At runtime:

- **CloudFront** owns request routing and caching  
- **API Gateway** owns request validation and Lambda invocation  
- **Lambda** owns request processing and Bedrock invocation  
- **Bedrock Agent** owns reasoning and retrieval  
- **Bedrock Knowledge Base** owns vector search and document retrieval  

Each service is responsible for its own operational behavior, with no cross‑service responsibilities.

---

# **3. Change Management**

## **3.1 Infrastructure Changes**
All infrastructure changes must:

- Be made in Terraform  
- Pass validation (`terraform validate`)  
- Pass plan review (`terraform plan`)  
- Be deployed via CI/CD  

No manual changes are permitted in:

- CloudFront  
- API Gateway  
- IAM  