- ACM certificate  
- API Gateway HTTP API  
- Lambda function definition  
- IAM roles and policies  
- Bedrock Agent (DRAFT definition only)  

Terraform **does not** manage:

- Agent versions  
- Agent aliases  
- KB ingestion jobs  
- Lambda environment variable updates for alias IDs  

These are dynamic and would cause drift if managed declaratively.

## **2.2 CI/CD Owns Dynamic Lifecycle**
GitHub Actions handles:

- KB ingestion  
- Agent alias creation (if missing)  
- Lambda environment variable updates  
- Deployment of Lambda code  
- Uploading KB files  

This ensures:

- No stale alias IDs  
- No Terraform drift  
- No accidental recreation of agents  
- Clean, predictable updates  

---

# **3. API Design Decisions**

## **3.1 HTTP API Instead of REST API**
HTTP API was chosen because:

- Lower latency  
- Lower cost  
- Simpler routing  
- Native support for Lambda proxy integration  
- Cleaner CORS configuration  

REST API was unnecessary and would add complexity.

## **3.2 Single Route: `POST /chat`**
The system intentionally exposes only one public API route:

```
POST /chat
```

This keeps:

- The attack surface minimal  
- The API contract simple  
- The frontend integration straightforward  

## **3.3 Stage Handling**