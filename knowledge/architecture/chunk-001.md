# **🏗️ Mr. Beefy — System Architecture (Final Production Design)**  
*Comprehensive technical overview of the deployed system*

---

# **1. High‑Level Architecture Overview**

Mr. Beefy is a fully serverless, event‑driven AI agent platform built on AWS.  
The system consists of four major layers:

1. **Frontend Delivery Layer**  
   - CloudFront distribution  
   - S3 static hosting with Origin Access Control (OAC)  
   - Custom domain + ACM certificate + Route53  

2. **API Layer**  
   - API Gateway HTTP API  
   - CloudFront → API Gateway integration  
   - `/chat` endpoint mapped to Lambda  

3. **Compute Layer**  
   - Node.js 20 Lambda function  
   - Bedrock Agent Runtime client  
   - Environment variables for Agent ID + Alias ID  

4. **AI Layer**  
   - Bedrock Agent  
   - Bedrock Knowledge Base  
   - Titan V2 embeddings  
   - S3 Vector Store  
   - IAM roles for agent execution + KB ingestion  

All infrastructure is deployed via **Terraform**, with dynamic agent lifecycle operations handled by **GitHub Actions CI/CD**.

---

# **2. Frontend Architecture**

## **2.1 Static Hosting**
- React SPA built and uploaded to an S3 bucket:
  - Bucket name pattern: `mrbeefy-frontend-<random>`  