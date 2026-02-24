1. Lambda receives the agent output.  
2. Lambda formats the response for the UI.  
3. Lambda returns the response to API Gateway.

### **3.7 CloudFront Return Path**
1. API Gateway returns the response to CloudFront.  
2. CloudFront forwards the response to the browser.  
3. UI renders the assistant message.

---

# **4. Knowledge Base Workflow**

### **4.1 KB File Management**
1. Machine‑readable KB files are stored in a dedicated folder in the repository.  
2. CI/CD uploads these files to the Knowledge Base S3 bucket.

### **4.2 Ingestion Workflow**
**Exact behavior (no vague phrasing):**

1. CI/CD calls the Bedrock Knowledge Base ingestion API to start a new ingestion job.  
2. Bedrock performs the ingestion process:
   - Reads documents from the KB S3 bucket  
   - Generates embeddings using Titan V2  
   - Writes vectors to the S3 Vector Store  
   - Updates the vector index  

### **4.3 Retrieval Workflow**
During a chat request:

1. The agent embeds the user query.  
2. The agent queries the vector index.  
3. Relevant documents are returned.  
4. The agent uses retrieved content to generate the final answer.

---

# **5. Agent Lifecycle Workflow**

### **5.1 Agent Definition**