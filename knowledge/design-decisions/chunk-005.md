## **7.2 Explicit Ingestion**
KB ingestion is triggered manually via CI/CD because:

- AWS does not auto-ingest  
- Ingestion should be deterministic  
- KB updates should be intentional  

---

# **8. IAM Design Decisions**

## **8.1 Least Privilege**
Each role has only the permissions required for its function.

### **Lambda Role**
- Logging  
- `bedrock:InvokeAgent`  

### **Agent Execution Role**
- Model invocation  
- KB retrieval  
- S3 read access  
- Vector store operations  

### **KB Role**
- S3 read  
- s3vectors operations  
- Titan embedding model invocation  

### **CloudFront OAC**
- `s3:GetObject` with `AWS:SourceArn` condition  

This structure isolates responsibilities and minimizes blast radius.

---

# **9. Frontend Design Decisions**

## **9.1 React SPA**
Chosen for:

- Fast development  
- Simple deployment  
- Easy integration with API Gateway  

## **9.2 Clean API Contract**
Frontend only calls:

```
POST /chat
```

No other endpoints are exposed.

## **9.3 CloudFront + S3 Hosting**
Provides:

- Global caching  
- Instant invalidation  
- Zero server maintenance  
- Strong security posture  

---

# **10. Deployment Design Decisions**

## **10.1 Terraform for Infrastructure**
Ensures:

- Reproducibility  
- Version control  