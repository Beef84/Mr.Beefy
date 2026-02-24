# **🛡️ Mr. Beefy — Governance Model**  
*Operational ownership, boundaries, and controls for the production system*

---

# **1. Purpose of Governance**

The governance model defines:

- **Who owns what**  
- **What processes are allowed**  
- **How changes are introduced**  
- **How stability is maintained**  
- **How risk is minimized**  
- **How the system remains predictable and maintainable over time**

This ensures the platform remains secure, consistent, and scalable as it evolves.

---

# **2. Ownership Model**

The system is governed by a clear separation of responsibilities across three domains:

## **2.1 Infrastructure Ownership (Terraform)**
Terraform owns:

- S3 buckets  
- CloudFront distribution  
- Route53 DNS records  
- ACM certificates  
- API Gateway HTTP API  
- Lambda function definition  
- IAM roles and policies  
- Bedrock Agent (DRAFT definition only)  

Terraform is the **single source of truth** for all static, long‑lived infrastructure.

Terraform does **not** own:

- Agent versions  
- Agent aliases  
- KB ingestion jobs  
- Lambda environment variable updates for alias IDs  

These are dynamic and governed by CI/CD.

---

## **2.2 Application Lifecycle Ownership (CI/CD)**
