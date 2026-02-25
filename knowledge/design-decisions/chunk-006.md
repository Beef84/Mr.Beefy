- Clear diffs  
- Safe rollbacks  

## **10.2 CI/CD for Dynamic Operations**
Ensures:

- No stale alias IDs  
- No Terraform drift  
- Clean agent lifecycle  
- Automated KB ingestion  

---

# **11. Knowledge Base Lifecycle Design Decisions**

## **11.1 Dual‑Path Ingestion Model**
The system now supports two ingestion paths:

1. **Backend Deployment Ingestion**  
   - Runs automatically during backend deploys  
   - Ensures the KB is refreshed whenever infrastructure or agent configuration changes  
   - Acts as a safety net to guarantee consistency after releases  

2. **Dedicated KB Ingestion Pipeline**  
   - Runs independently of backend deploys  
   - Allows documentation updates to be ingested without requiring a backend rollout  
   - Provides a safe, isolated ingestion workflow  

This separation reflects the reality that **knowledge evolves faster than infrastructure**.

---

## **11.2 Why a Separate KB Pipeline Was Introduced**
Originally, KB ingestion was tied to backend deployments. This created friction:

- Documentation updates required a full backend deploy  
- KB ingestion failures could block infrastructure releases  
- Terraform outputs were tightly coupled to ingestion  