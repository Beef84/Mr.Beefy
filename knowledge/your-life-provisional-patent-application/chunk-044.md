The knowledge base supports semantic search, retrieval, and style‑aware generation.

---

## Private agent implementation

A practitioner can implement the private agent using:

- **LLM inference API** (e.g., Bedrock, OpenAI, Anthropic, local models).
- **Tool‑based architecture** where the agent can call functions such as:
  - `search_private_kb`
  - `get_project_context`
  - `update_memory`
  - `summarize_items`
  - `generate_style_profile`

- **Context assembly logic** that:
  - retrieves relevant items from the knowledge base,
  - merges them with the user’s message,
  - applies the style profile,
  - and sends the combined context to the LLM.

- **Response streaming** back to the user.

This agent operates exclusively within the tenant’s private scope.

---

## Public agent implementation

A skilled engineer can implement the public agent by:

- Restricting its toolset to public‑only functions:
  - `list_public_items`
  - `search_public_kb`
  - `get_public_profile`
  - `get_public_project_summaries`

- Enforcing visibility constraints at:
  - the API layer,
  - the database query layer,
  - and the agent tool layer.

- Using the same style profile as the private agent, but with:
  - reduced context,