The system enforces strict tenant isolation at the storage and query layers.

---

## 4. Private AI Agent

The private agent is a tenant‑scoped AI system that:

- retrieves relevant content from the knowledge base  
- generates responses in the creator’s style  
- assists with project development  
- performs tasks such as summarization, drafting, planning, and organization  
- maintains continuity across sessions  

The agent uses a tool‑based architecture, where tools include:

- `search_private_kb`  
- `get_project_context`  
- `update_memory`  
- `summarize_items`  
- `generate_style_profile`  

The agent operates exclusively on private and collaborative content unless explicitly instructed to access community or public layers.

---

## 5. Project and Item Model

Each tenant may create multiple **projects**, each containing **items**. Items represent any unit of content, including:

- notes  
- transcripts  
- drafts  
- images  
- videos  
- summaries  
- tasks  
- external references  

Items may be:

- assigned to a single project  
- referenced across multiple projects  
- unassigned (general personal memory)  

The system maintains a **project‑item mapping table** to support cross‑project reuse.

---
