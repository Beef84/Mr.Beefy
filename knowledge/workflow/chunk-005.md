# **7. Infrastructure Provisioning Workflow**

### **7.1 Terraform Apply**
Terraform provisions:

- S3 buckets  
- IAM roles  
- Lambda function definition  
- API Gateway  
- CloudFront  
- Route53  
- ACM certificate  
- Bedrock Agent (DRAFT)  

### **7.2 Dependency Ordering**
Terraform ensures:

- ACM certificate validated before CloudFront  
- CloudFront created before Route53 alias  
- Lambda created before API Gateway integration  
- IAM roles created before Bedrock Agent  

### **7.3 Outputs to CI/CD**
Terraform outputs:

- Agent ID  
- KB ID  
- Lambda ARN  
- API ID  
- CloudFront distribution ID  

These values are consumed by CI/CD for dynamic operations.

---

# **8. Security Workflow**

### **8.1 Access Control**
- S3 frontend bucket locked behind OAC  
- KB bucket restricted to KB role  
- Lambda role restricted to logging + InvokeAgent  
- Agent execution role restricted to model + KB access  
- CloudFront restricted via `AWS:SourceArn`  

### **8.2 TLS**
- ACM certificate for domain  
- CloudFront enforces HTTPS  
- API Gateway enforces HTTPS  

### **8.3 IAM Separation**
Each component has a dedicated role with least‑privilege permissions.

---

# **9. Monitoring Workflow**

### **9.1 CloudWatch**
- Lambda logs  