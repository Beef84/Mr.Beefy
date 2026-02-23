- Payload format v2.0  
- Lambda receives user message  

### **5. Lambda calls Bedrock Agent Runtime**
- Using Agent ID + Alias ID  

### **6. Bedrock Agent**
- Searches Knowledge Base  
- Retrieves relevant documents  
- Generates response via Nova Pro  

### **7. Response flows back**
Agent → Lambda → API Gateway → CloudFront → Browser

---

# **10. Final Architecture Summary**

Mr. Beefy is a fully serverless, production‑grade AI platform with:

- Global CDN delivery  
- Secure static hosting  
- API routing via CloudFront  
- HTTP API with clean routing  
- Lambda compute with Bedrock integration  
- Knowledge Base retrieval + embeddings  
- Vector store indexing  
- Automated CI/CD lifecycle  
- Fully IaC‑managed infrastructure  

This architecture is scalable, reproducible, cost‑efficient, and designed for long‑term maintainability.

---