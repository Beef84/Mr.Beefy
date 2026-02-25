This ensures that every backend deploy results in a fully refreshed KB.

**But this is no longer the only ingestion path.**

---

## **2. The dedicated KB pipeline handles ingestion between deploys**
This new pipeline is intentionally minimal and focused:

### **Inputs**
- `/knowledge` directory  
- SSM parameter: `mrbeefy.kb.bucket_name`  
- SSM parameter: KB ID  

### **Actions**
- Syncs knowledge files → S3 (non‑destructive)  
- Triggers a Bedrock KB ingestion job  
- Waits for ingestion to complete  
- Reports success/failure  

### **Outputs**
- Updated embeddings  
- Updated vector index  
- A refreshed KB without touching backend infrastructure  

---

# **🔄 Why Both Pipelines Trigger Ingestion**

### **Backend ingestion**
- Ensures the KB is always correct after infra changes  
- Guarantees the KB is aligned with the deployed agent  
- Acts as a safety net during releases  

### **Dedicated KB ingestion**
- Allows rapid iteration on documentation  
- Avoids unnecessary backend deploys  
- Keeps the KB fresh even when the backend is stable  
- Reduces risk by isolating ingestion failures from backend releases  

Together, they create a **dual‑path ingestion model**:

- **Backend deploy → full system refresh**  