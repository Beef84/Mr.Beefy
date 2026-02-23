  - Public access fully blocked  
  - Access controlled exclusively through CloudFront OAC  

## **2.2 CloudFront Distribution**
CloudFront serves as the global CDN and routing layer.

### **Origins**
1. **S3 Frontend Origin**
   - Uses Origin Access Control (OAC)  
   - Only CloudFront can read from the bucket  
   - S3 bucket policy restricts access via `AWS:SourceArn`  

2. **API Gateway Origin**
   - Domain: `<api-id>.execute-api.<region>.amazonaws.com`  
   - **origin_path = "/prod"** to map CloudFront `/chat` → API Gateway `/prod/chat`  
   - HTTPS enforced  
   - TLSv1.2  

### **Behaviors**
- **Default behavior** → S3 frontend  
- **Ordered behavior**:
  - `path_pattern = "/chat"`  
  - Allowed methods:  
    `GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE`  
  - Cached methods:  
    `GET, HEAD`  
  - Cache policy: API no‑cache policy  
  - Origin request policy: forwards `Content-Type` header + all query strings  

### **Security**
- ACM certificate for `mrbeefy.academy`  
- SNI‑only  
- Security headers policy applied to frontend  

## **2.3 DNS**
- Route53 A‑record alias → CloudFront distribution  
- Certificate validated via DNS  

---

# **3. API Architecture**

## **3.1 API Gateway (HTTP API)**