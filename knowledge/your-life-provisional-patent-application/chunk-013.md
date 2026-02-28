- controlled agent tool access  

This architecture supports future expansion into per‑tenant accounts or dedicated compute clusters.

---

## 10. Agent Orchestration and Routing

The system includes an orchestration layer that:

- routes user messages to the appropriate agent  
- retrieves relevant memory  
- enforces visibility constraints  
- selects tools based on context  
- streams responses back to the user  

Routing decisions are based on:

- tenant identity  
- project context  
- visibility layer  
- agent type (private, collaborative, community, public)  

This ensures that each agent operates within its intended scope.

---

## 11. Security and Privacy Controls

The system enforces:

- strict tenant isolation  
- role‑based access control  
- item‑level permissions  
- project‑level membership  
- public/private visibility flags  
- audit logging  
- encrypted storage and transport  

Public agents are prevented from accessing private or collaborative content through enforced tool restrictions and scoped retrieval mechanisms.

---

## 12. Extensibility and Future Enhancements

The architecture supports future enhancements such as:

- per‑tenant compute scaling  
- dedicated vector databases  