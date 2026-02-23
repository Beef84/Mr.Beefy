# **🧩 Mr. Beefy — Design Decisions (Final Architecture Rationale)**  
*Technical justification for the system’s structure, components, and responsibilities*

---

# **1. Guiding Principles**

The design of Mr. Beefy followed a consistent set of engineering principles:

- **Separation of concerns** between static infrastructure, dynamic agent lifecycle, and runtime behavior  
- **Deterministic deployments** using Terraform for infrastructure and CI/CD for dynamic operations  
- **Minimal surface area** for IAM permissions  
- **Serverless-first architecture** for scalability and cost efficiency  
- **Explicitness over convention**, especially with AWS services that have hidden or implicit state  
- **Simplicity at the edges, intelligence at the core** — the frontend stays thin, the backend stays predictable, and Bedrock handles reasoning  

These principles shaped every decision documented below.

---

# **2. Infrastructure Ownership Model**

## **2.1 Terraform Owns Static Infrastructure**
Terraform manages all resources that are:

- Declarative  
- Long‑lived  
- Stable  
- Not subject to frequent versioning  

This includes:

- S3 buckets (frontend + knowledge)  
- CloudFront distribution  
- Route53 records  