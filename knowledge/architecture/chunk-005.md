## **7.1 Responsibilities**
CI/CD handles all dynamic operations:

- Build Lambda bundle  
- Deploy Terraform  
- Upload KB files  
- Trigger KB ingestion  
- Associate KB with agent  
- Create alias if missing  
- Update Lambda environment variables with alias ID  

## **7.2 Why CI/CD Owns This**
- Bedrock agent versions and aliases are dynamic  
- Terraform cannot safely manage them without drift  
- CI/CD ensures clean, deterministic updates  

---

# **8. Terraform Architecture**

## **8.1 Terraform Owns**
- S3 buckets  
- IAM roles and policies  
- Lambda function (static definition)  
- API Gateway  
- CloudFront  
- Route53  
- ACM certificate  
- Bedrock Agent (DRAFT definition only)  

## **8.2 Terraform Does NOT Own**
- Agent versions  
- Agent aliases  
- KB ingestion jobs  
- Lambda environment variable updates for alias IDs  

These are handled by CI/CD to avoid drift and stale state.

---

# **9. End‑to‑End Request Flow**

### **1. User sends message from UI**
```
POST https://mrbeefy.academy/chat
```

### **2. CloudFront behavior matches `/chat`**
- Forwards request to API Gateway origin  
- Prepends `/prod` via origin_path  

### **3. API Gateway receives**
```
POST /prod/chat
```

### **4. API Gateway invokes Lambda**