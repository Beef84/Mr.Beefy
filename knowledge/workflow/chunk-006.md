- API Gateway access logs  
- API Gateway execution logs  

### **9.2 CloudFront**
- Cache hit/miss metrics  
- Optional standard logs  

### **9.3 Bedrock**
- KB ingestion job status  
- Agent invocation metrics  

---

# **10. Summary**

The Mr. Beefy workflow is a fully serverless, tightly integrated system that:

- Delivers a global frontend  
- Routes chat requests through CloudFront  
- Executes logic in Lambda  
- Delegates reasoning to Bedrock  
- Retrieves context from a vectorized Knowledge Base  
- Automates lifecycle operations via CI/CD  
- Maintains infrastructure via Terraform  

This workflow ensures the system is scalable, maintainable, secure, and production‑ready.

---