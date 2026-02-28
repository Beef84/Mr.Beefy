   v                                   v
+-------------------+        +-----------------------+
| Shared Item       |<------>| Collaborator View     |
+-------------------+        +-----------------------+
   |                                   |
   | Comments / Edits                  |
   v                                   |
+-------------------+                  |
| Collaboration Log |------------------+
+-------------------+
```

---

## **Diagram 7 — Community Publishing Flow**

```
Tenant
   |
   | Publish Item
   v
+-----------------------+
| Publishing Module     |
+-----------------------+
   |
   | Community Metadata
   v
+-----------------------+
| Community Database    |
+-----------------------+
   |
   | Feed Query
   v
+-----------------------+
| Community Feed        |
+-----------------------+
   |
   | Likes / Comments
   v
+-----------------------+
| Engagement Tracking   |
+-----------------------+
```

---

## **Diagram 8 — Public Agent Interaction Flow**

```
External User
    |
    v
+-----------------------+
| Public Chat Interface |
+-----------------------+
    |
    v
+-----------------------+
| Public Agent          |
| Orchestrator          |
+-----------------------+
    |
    | Public-Only Tools
    v