Terraform defines the agent in DRAFT state, including:

- Instruction block  
- Execution role  
- Foundation model  

### **5.2 Alias Lifecycle**
1. CI/CD checks whether the alias exists.  
2. If the alias does not exist, CI/CD creates it.  
3. CI/CD updates Lambda environment variables with:
   - `AGENT_ID`  
   - `AGENT_ALIAS_ID`  

### **5.3 Versioning**
- Bedrock automatically creates implicit versions.  
- Terraform does not manage versions or aliases.  
- CI/CD ensures the alias always points to the correct version.

---

# **6. CI/CD Workflow**

### **6.1 Trigger Conditions**
Pipeline runs on:

- Push to main  
- Manual dispatch  
- KB file changes  
- Lambda code changes  

### **6.2 Pipeline Steps**
1. Build Lambda bundle.  
2. Deploy Terraform.  
3. Upload KB files to the KB S3 bucket.  
4. **Start a Knowledge Base ingestion job using the Bedrock ingestion API.**  
5. Associate the KB with the agent if needed.  
6. Create the agent alias if missing.  
7. Update Lambda environment variables with the alias ID.  
8. Invalidate CloudFront cache.

### **6.3 Outputs**
- Updated infrastructure  
- Updated KB index  
- Updated agent alias  
- Updated Lambda runtime  
- Updated frontend  

---
