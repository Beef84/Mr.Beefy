The platform now includes a **standalone Knowledge Base ingestion pipeline** that operates independently from the backend deployment workflow. While the backend still performs a KB ingestion as part of a full system rollout, the new dedicated pipeline allows documentation updates to be ingested without requiring a backend deploy. This separation dramatically improves iteration speed, safety, and clarity across the system.

---

# **🎯 Why This Pipeline Exists**
Previously, the only way to refresh the Knowledge Base was to run the backend deployment pipeline. This created several problems:

- Documentation changes required a full backend deploy  
- Ingestion was tightly coupled to Terraform outputs  
- Failures in the KB ingest path could block backend releases  
- The KB could not be updated independently or frequently  

The new pipeline solves all of these issues by giving the KB its own lifecycle.

---

# **⚙️ How the System Works Now**

## **1. Backend still performs ingestion — but only during deploys**
The backend pipeline continues to:

- Deploy infrastructure  
- Publish the knowledge bucket name to SSM  
- Associate the KB with the agent  
- Trigger a full ingestion as part of a release  
