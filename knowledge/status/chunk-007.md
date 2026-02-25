- **KB pipeline → documentation‑only refresh**  

This mirrors real‑world AI infra patterns where knowledge updates and infrastructure updates move at different speeds.

---

# **🚀 Impact**
The addition of the dedicated KB ingestion pipeline provides:

- Faster documentation iteration  
- Safer ingestion cycles  
- Clear separation of concerns  
- Reduced coupling between infra and knowledge  
- A more resilient and maintainable architecture  

The backend still owns ingestion during deploys, but the KB pipeline now owns ingestion during day‑to‑day updates — exactly the right division of responsibilities.

---

# **🖥️ Frontend UI Updates**

## **Overview**
The frontend has evolved from a minimal prototype into a polished, production‑quality chat interface that reflects the engineering philosophy behind Mr. Beefy. The UI now supports rich agent responses, improved interaction patterns, and a cohesive visual design aligned with the rest of the platform.

---

# **✨ Major Improvements**

## **1. Markdown Rendering for Agent Responses**
The UI now uses a Markdown renderer to display assistant messages. This enables:

- **Bold and italic text**
- **Headings**
- **Lists**
- **Multi‑paragraph responses**
- **Code blocks**