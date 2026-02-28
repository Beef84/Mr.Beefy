|  | Linguistic Model  |                                        |
|  +-------------------+                                        |
|                                                               |
|  +-------------------+                                        |
|  | Project-Item Map  |                                        |
|  +-------------------+                                        |
+---------------------------------------------------------------+
```

---

## **Diagram 4 — Private Agent Interaction Flow**

```
User Message
    |
    v
+-----------------------+
| Agent Orchestrator    |
+-----------------------+
    | Context Resolution
    v
+-----------------------+
| Tool Selection        |
| - search_private_kb   |
| - get_project_context |
| - update_memory       |
+-----------------------+
    |
    | Retrieved Memory
    v
+-----------------------+
| LLM Inference Engine  |
| (Style-Aware)         |
+-----------------------+
    |
    v
User Response (Chat)
```

---

## **Diagram 5 — Multi‑Layer Sharing Model**

```
                +----------------------+
                |      PUBLIC          |
                |  (External World)    |
                +----------+-----------+
                           ^