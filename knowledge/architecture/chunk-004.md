- Foundation model: **amazon.nova-pro-v1:0**  
- Instruction block defines:
  - KB usage rules  
  - Response rules  
  - Action rules  
- Agent resource role attached  

## **5.2 Agent Execution Role**
Permissions include:

### **Model Invocation**
- `bedrock:InvokeModel`  
- `bedrock:InvokeModelWithResponseStream`  

### **Knowledge Base Retrieval**
- `bedrock:Retrieve`  
- `bedrock:RetrieveAndGenerate`  

### **KB S3 Access**
- `s3:ListBucket`  
- `s3:GetObject`  

### **Vector Store**
- `s3vectors:CreateIndex`  
- `s3vectors:DeleteIndex`  
- `s3vectors:GetIndex`  
- `s3vectors:ListIndexes`  
- `s3vectors:PutVectors`  
- `s3vectors:GetVectors`  
- `s3vectors:DeleteVectors`  
- `s3vectors:QueryVectors`  

---

# **6. Knowledge Base Architecture**

## **6.1 Storage**
- S3 bucket containing machine‑readable KB files  
- Terraform generates bucket  
- CI/CD uploads KB files  

## **6.2 Vector Store**
- Backed by **S3 Vector Store**  
- Embedding model: **amazon.titan-embed-text-v2:0**  
- Index created and managed by Bedrock  

## **6.3 KB Ingestion**
- Triggered explicitly via CI/CD  
- Uses KB role with:
  - S3 read permissions  
  - s3vectors permissions  
  - Titan embedding model permissions  

---

# **7. CI/CD Architecture**
