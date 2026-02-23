Defaults hide behavior.  
Hidden behavior becomes hidden bugs.

So I make everything explicit:

- Regions  
- Permissions  
- Routing paths  
- Origin mappings  
- Environment variables  
- Deployment steps  
- Ingestion triggers  

Explicit systems are easier to reason about, easier to debug, and easier to evolve.

---

# **4. Design for Observability First**

A system without visibility is a system waiting to fail.

I design with observability as a first‑class requirement:

- Lambda logs  
- API Gateway access logs  
- API Gateway execution logs  
- CloudFront metrics  
- KB ingestion status  
- Bedrock invocation metrics  

If something goes wrong, I want the system to tell me *exactly* where and why.

---

# **5. Keep Each Component Small and Focused**

Every part of the system should have a single, clear responsibility.

- Lambda handles request → agent invocation  
- Agent handles reasoning  
- KB handles retrieval  
- CloudFront handles routing  
- IaC handles infrastructure  
- CI/CD handles lifecycle  

When each piece does one thing well, the whole system becomes easier to maintain, scale, and extend.

---

# **6. Build for Reproducibility**
