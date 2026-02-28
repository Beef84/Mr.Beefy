Community content is stored in a shared relational database with tenant identifiers and visibility flags. The system supports future expansion into graph‑based ranking and recommendation engines.

---

## 8. Public AI Representative

Each tenant receives a **public‑facing AI agent** that:

- communicates in the creator’s voice  
- presents their work  
- answers questions from external users  
- directs visitors to relevant destinations  
- handles actions such as scheduling or purchasing  

The public agent operates on a restricted dataset consisting only of:

- public items  
- public project summaries  
- public profile information  
- public style profile  

The public agent may be embedded on external websites or connected to third‑party platforms.

---

## 9. Multi‑Tenant Cloud Architecture

The system is deployed as a multi‑tenant cloud environment with:

- isolated tenant data boundaries  
- shared compute resources  
- tenant‑scoped configuration  
- centralized control plane  
- scalable ingestion pipelines  
- per‑tenant agent instances  

Tenant isolation is enforced through:

- access control policies  
- tenant identifiers in all data models  
- scoped API routes  
- isolated vector index partitions  