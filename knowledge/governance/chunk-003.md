- S3 bucket configuration  
- Route53  
- Lambda configuration (except environment variables updated by CI/CD)

This prevents drift and ensures reproducibility.

---

## **3.2 Agent Lifecycle Changes**
All agent lifecycle changes must be performed through CI/CD:

- Alias creation  
- Alias updates  
- KB ingestion  
- KB association  
- Lambda environment variable updates  

Terraform must not manage these resources to avoid drift and stale state.

---

## **3.3 Knowledge Base Updates**
KB updates follow a strict workflow:

1. Update machine‑readable KB files in the repo  
2. CI/CD uploads files to the KB S3 bucket  
3. CI/CD starts a new ingestion job  
4. Bedrock updates the vector index  

Manual ingestion is not permitted.

---

# **4. Security Governance**

## **4.1 IAM Governance**
IAM roles follow strict least‑privilege rules:

- Lambda role: logging + `InvokeAgent`  
- Agent execution role: model invocation + KB retrieval + vector store access  
- KB role: S3 read + vector store operations + Titan embedding model  
- CloudFront OAC: `s3:GetObject` with `AWS:SourceArn` restriction  

No role may be expanded without explicit justification.

---

## **4.2 Network Governance**
- All traffic is HTTPS‑only  