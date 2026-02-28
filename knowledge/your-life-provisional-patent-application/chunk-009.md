- **Content Extraction** — Text is segmented, normalized, and enriched with metadata such as timestamps, speaker identification, and project associations.
- **Summarization** — AI models generate summaries, key points, tasks, and semantic tags.
- **Embedding Generation** — Content is converted into vector embeddings using an embedding model.
- **Knowledge Base Storage** — Embeddings and metadata are stored in a tenant‑scoped vector index and relational database.

This pipeline ensures that all content becomes part of a structured, searchable, and retrievable memory system.

---

## 3. Personal Knowledge Base

Each tenant has a **personal knowledge base** consisting of:

- **Vector Store** — Stores embeddings for semantic retrieval.
- **Relational Store** — Stores metadata, project associations, permissions, and content descriptors.
- **Style Profile** — A structured representation of the creator’s linguistic patterns, tone, pacing, and stylistic preferences, derived from their content.

The knowledge base supports:

- contextual retrieval  
- cross‑project referencing  
- style‑consistent generation  
- memory‑augmented agent responses  
