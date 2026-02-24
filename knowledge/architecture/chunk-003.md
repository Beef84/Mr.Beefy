- Protocol: **HTTP API** (not REST API)  
- Stage: **prod**  
- Stage does **not** appear in CloudFront URL due to origin_path mapping  
- CORS enabled:
  - Allowed origins: `https://mrbeefy.academy`  
  - Allowed methods: `OPTIONS, POST`  
  - Allowed headers: `content-type`  

## **3.2 Routes**
- **POST /chat**  
  - Integrated with Lambda via AWS_PROXY  
  - Payload format version: 2.0  

## **3.3 Lambda Invocation Permissions**
Lambda permission allows API Gateway to invoke the function:

```
lambda:InvokeFunction
source_arn = <api-gateway-execution-arn>/*/*
```

---

# **4. Compute Architecture (Lambda)**

## **4.1 Lambda Function**
- Runtime: **Node.js 20.x**  
- Handler: `index.handler`  
- Timeout: 30 seconds  
- Deployed via CI/CD (zip artifact)  
- Environment variables:
  - `AGENT_ID`
  - `AGENT_ALIAS_ID` (updated by CI/CD after alias creation)  

## **4.2 Lambda IAM Role**
Permissions include:

### **Logging**
- `logs:CreateLogGroup`  
- `logs:CreateLogStream`  
- `logs:PutLogEvents`  

### **Bedrock Agent Runtime**
- `bedrock:InvokeAgent`  

Lambda does **not** need direct access to S3 or vector store — the agent handles retrieval.

---

# **5. AI Architecture (Bedrock)**

## **5.1 Bedrock Agent**