+-----------------------+     +---------------------------+
| Public KB Retrieval   |<--->| Public Knowledge Base     |
+-----------------------+     +---------------------------+
    |
    | Style-Aware LLM
    v
+-----------------------+
| Response Generator    |
+-----------------------+
    |
    v
External User Output
```

---

## **Diagram 9 — Multi‑Tenant Cloud Deployment**

```
+---------------------------------------------------------------+
|                     AWS ORGANIZATION                          |
+---------------------------------------------------------------+
|                                                               |
|  +------------------+   +------------------+   +-------------+|
|  |  DEV ACCOUNT     |   | STAGING ACCOUNT  |   | PROD ACCT   ||
|  |------------------|   |------------------|   |-------------||
|  | Tenant Plane     |   | Tenant Plane     |   | Tenant Plane||
|  | Control Plane    |   | Control Plane    |   | Control     ||
|  | AI Plane Access  |   | AI Plane Access  |   | Plane       ||
|  +------------------+   +------------------+   +-------------+|
|                                                               |