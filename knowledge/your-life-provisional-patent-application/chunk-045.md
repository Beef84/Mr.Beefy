  - public‑only memory,
  - and safety filters.

- Embedding the agent in:
  - websites,
  - social platforms,
  - or external applications.

This agent acts as the creator’s public representative.

---

## Visibility enforcement

A practitioner can implement visibility enforcement using:

- **Visibility filter engine** that rewrites queries based on scope.
- **Permission resolver** that checks:
  - tenant identity,
  - collaborator roles,
  - item‑level permissions,
  - project membership.

- **Scope‑restricted query builder** that ensures:
  - private items are only accessible to the tenant,
  - collaborative items are accessible only to authorized collaborators,
  - community items are accessible to all tenants,
  - public items are accessible externally.

- **Public‑only retrieval module** that prevents the public agent from accessing private memory.

This layer ensures privacy and safety across all interactions.

---

## Collaboration and community implementation

A skilled engineer can implement collaboration by:

- Creating a **collaboration table** linking items to collaborators.
- Providing **role‑based access** (owner, editor, viewer).
- Logging all collaborative actions.