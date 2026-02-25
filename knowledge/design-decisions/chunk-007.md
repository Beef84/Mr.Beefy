- No safe way to update the KB independently  

The dedicated pipeline resolves these issues by giving the KB its own lifecycle.

---

## **11.3 SSM as the Source of Truth**
The backend pipeline now publishes:

- KB bucket name  
- KB ID  

…into SSM parameters.

The KB pipeline reads these values at runtime, ensuring:

- No Terraform coupling  
- No querying the KB for data source ARNs  
- No brittle assumptions about resource recreation  
- A stable, explicit contract between pipelines  

SSM becomes the **canonical interface** between backend deploys and KB ingestion.

---

## **11.4 Non‑Destructive S3 Sync**
The KB pipeline intentionally avoids destructive sync flags.

This prevents:

- Metadata loss  
- Embedding corruption  
- Ingestion failures caused by missing files  

Only new or updated files are uploaded, preserving the integrity of the vector store.

---

## **11.5 Explicit, Isolated Ingestion Jobs**
The KB pipeline triggers ingestion directly via the Bedrock API.

This ensures:

- Deterministic ingestion  
- Clear failure boundaries  
- No interference with backend deploys  
- A clean, minimal workflow focused solely on knowledge updates  
