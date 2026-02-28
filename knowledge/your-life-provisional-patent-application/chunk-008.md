The system consists of three primary architectural planes:

- **Control Plane** — Manages tenant provisioning, authentication, billing, global configuration, and platform‑wide services.
- **Tenant Plane** — Contains all creator‑specific resources, including private knowledge bases, project structures, ingestion pipelines, and private/public agents.
- **AI Plane** — Provides shared AI capabilities, including model inference, embeddings, style modeling, and agent orchestration.

Each creator is treated as a **tenant**, with isolated data boundaries and dedicated logical resources. All content, metadata, and agent interactions are scoped to the tenant unless explicitly shared through collaboration, community publishing, or public exposure.

---

## 2. Data Ingestion and Processing Pipeline

The system ingests multiple forms of user‑generated content, including text, audio, video, and images. The ingestion pipeline performs the following operations:

- **Upload Handling** — Content is received through authenticated API endpoints and stored in tenant‑scoped object storage.
- **Transcription** — Audio and video files are automatically transcribed using an AI transcription service.