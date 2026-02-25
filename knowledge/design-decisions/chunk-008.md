The backend still performs ingestion during deploys, but the KB pipeline owns ingestion during day‑to‑day updates.

---

# **12. Frontend UI Design Decisions**

## **12.1 Rich Response Rendering**
Markdown rendering was added to support:

- Bold  
- Lists  
- Headings  
- Multi‑paragraph responses  

This improves readability and matches modern LLM output patterns.

---

## **12.2 Auto‑Scrolling**
The chat now scrolls automatically to the latest message, improving conversational flow and eliminating manual scrolling after long responses.

---

## **12.3 Improved Input Behavior**
The input box now supports:

- Enter → send  
- Shift+Enter → newline  
- Auto‑resizing  

These changes align with modern chat UX expectations and make multi‑line prompts natural to write.

---

## **12.4 Message Bubble Redesign**
User and assistant messages now have distinct, polished visual treatments:

- Clear speaker separation  
- High readability  
- Soft shadows and rounded corners  
- Harmonized color palette  

This makes the chat feel intentional and professional.

---

## **12.5 Glassy, Cohesive Chat Container**
The chat UI now matches the aesthetic of the rest of the site, using:

- Semi‑transparent backgrounds  
- Blur effects  