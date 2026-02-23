- Frontend delivery (CloudFront + S3 + OAC)  
- API routing (CloudFront → API Gateway)  
- Compute layer (Lambda)  
- AI layer (Bedrock Agent, Knowledge Base, vector store)  
- CI/CD lifecycle and responsibilities  
- IaC boundaries  
- End‑to‑end request flow  

This section explains how the system is built and how each component interacts.

---

## **🧩 Design Decisions**
A deep explanation of the reasoning behind the architecture:

- IaC vs CI/CD ownership  
- Serverless‑first design  
- Explicit routing and origin mapping  
- Agent lifecycle strategy  
- KB ingestion strategy  
- IAM least‑privilege boundaries  
- Observability and reproducibility principles  

This section documents the “why” behind every major choice.

---

## **🔄 Workflows**
Step‑by‑step operational flows for:

- Frontend delivery  
- Chat request processing  
- Lambda → Bedrock invocation  
- Knowledge Base ingestion  
- Agent versioning and aliasing  
- CI/CD deployment lifecycle  
- Infrastructure provisioning  

This section shows how the system behaves in practice.

---

## **🛡️ Governance**
The rules and boundaries that ensure system stability:

- Ownership model (IaC, CI/CD, runtime)  
- Change management processes  
- Security governance  