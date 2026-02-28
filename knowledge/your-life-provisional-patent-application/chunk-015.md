+---------------------------+     +----+--------------------+     +---------------------------+
|        AI PLANE           |     |      TENANT PLANE       |     |        AI MODELS          |
|---------------------------|     |-------------------------|     |---------------------------|
| LLM Inference             |<--->| Private Agent           |<--->| LLMs (Chat, Style, Tools) |
| Embedding Generator       |     | Public Agent            |     | Embedding Models          |
| Agent Orchestration       |     | Projects & Items        |     | Summarization Models      |
+---------------------------+     | Personal KB (Vector+DB) |     +---------------------------+
                                  | Ingestion Pipeline      |
                                  | Collaboration Layer     |
                                  | Community Layer         |
                                  +-------------------------+
```

---

## **Diagram 2 — Ingestion & Knowledge Pipeline**

```
User Device
    |
    v
+------------------+        +-----------------------+
| Upload API       |------->| Tenant S3 Storage     |
+------------------+        +-----------------------+
                                 |