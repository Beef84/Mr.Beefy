   wherein all agent queries are rewritten to enforce private, collaborative, community, or public visibility constraints.

5. **The system of claim 4**, wherein content transitions between visibility layers require explicit user action and are logged for auditability.

---

## **Claims Covering the Ingestion Pipeline**

6. **A unified ingestion pipeline** that:  
   - receives user‑generated content in multiple modalities;  
   - transcribes audio and video;  
   - extracts metadata;  
   - generates summaries and semantic tags;  
   - produces vector embeddings;  
   - and stores all outputs in a tenant‑scoped knowledge base.

7. **The system of claim 6**, wherein the ingestion pipeline automatically updates the creator’s stylistic profile based on new content.

---

## **Claims Covering the Personal Knowledge Base**

8. **A personal knowledge base** comprising:  
   - a vector index partitioned by tenant;  
   - a relational metadata store;  
   - a style profile store;  
   - and a cross‑project mapping table;  
   wherein the knowledge base supports semantic retrieval, stylistic generation, and multi‑project referencing.
