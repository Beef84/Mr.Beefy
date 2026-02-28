                           | Publish Public Items
                           |
                +----------+-----------+
                |      COMMUNITY       |
                | (All Platform Users) |
                +----------+-----------+
                           ^
                           | Publish to Community
                           |
                +----------+-----------+
                |    COLLABORATIVE     |
                | (Selected Users Only)|
                +----------+-----------+
                           ^
                           | Share Item
                           |
                +----------+-----------+
                |       PRIVATE        |
                | (Creator Only)       |
                +----------------------+
```

---

## **Diagram 6 — Collaboration Flow**

```
Tenant A                         Collaborator
   |                                   |
   | Share Item                        |
   v                                   |
+-------------------+                  |
| Permission Module |                  |
+-------------------+                  |
   |                                   |
   | Creates item_share entry          |