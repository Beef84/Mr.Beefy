# **🔄 Mr. Beefy — System Workflow (End‑to‑End Operational Flow)**  
*Detailed description of how data, requests, and processes move through the system*

---

# **1. Overview**

The Mr. Beefy platform operates through coordinated workflows across:

- **Frontend delivery**  
- **API request handling**  
- **Lambda compute execution**  
- **Bedrock Agent orchestration**  
- **Knowledge Base retrieval**  
- **CI/CD automation**  
- **Infrastructure provisioning**

Each workflow below describes the exact sequence of operations and the responsibilities of each component.

---

# **2. Frontend Delivery Workflow**

### **2.1 Build**
1. The React application is compiled into a static asset bundle.  
2. Output includes `index.html`, JavaScript bundles, CSS, and static assets.

### **2.2 Deployment**
1. CI/CD uploads the build artifacts to the S3 frontend bucket.  
2. CI/CD issues a CloudFront invalidation to propagate updates globally.

### **2.3 User Access**
1. User navigates to `https://mrbeefy.academy`.  
2. Route53 resolves the domain to CloudFront.  
3. CloudFront retrieves static assets from S3 using OAC.  
4. The browser loads the SPA and initializes the UI.

---

# **3. Chat Request Workflow**

### **3.1 User Action**