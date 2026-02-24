1. User enters a message in the UI.  
2. The UI sends a `POST` request to:

```
https://mrbeefy.academy/chat
```

### **3.2 CloudFront Routing**
1. CloudFront matches the `/chat` behavior.  
2. CloudFront forwards the request to the API Gateway origin.  
3. CloudFront prepends the stage path using:

```
origin_path = "/prod"
```

Resulting in:

```
POST /prod/chat
```

### **3.3 API Gateway Processing**
1. API Gateway receives the request.  
2. CORS validation occurs.  
3. Route `POST /chat` is matched.  
4. API Gateway invokes the Lambda function using AWS_PROXY integration.

### **3.4 Lambda Execution**
1. Lambda receives the event (payload format v2.0).  
2. Lambda extracts:
   - User message  
   - Agent ID  
   - Agent Alias ID  
3. Lambda initializes the Bedrock Agent Runtime client.  
4. Lambda sends the user message to the Bedrock Agent using `InvokeAgent`.

### **3.5 Bedrock Agent Workflow**
1. The agent receives the request.  
2. The agent performs a Knowledge Base search:
   - Embeds the query using Titan V2  
   - Queries the S3 Vector Store  
   - Retrieves relevant documents  
3. The agent generates a response using Nova Pro.  
4. The agent returns the structured output to Lambda.

### **3.6 Lambda Response**