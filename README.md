# **AI Infrastructure Engineering Journey 2026**  
*A practical, project‑driven roadmap documenting my transition from Senior DevOps Engineer to AI Infrastructure Engineer — centered around building a real, public-facing AI system on AWS.*

For more than a decade, my work has focused on **DevOps engineering, cloud automation, and backend systems**, with deep experience in:

- CI/CD pipelines and release automation  
- Infrastructure‑as‑Code  
- .NET and distributed backend engineering  
- Containerization and cloud-native workflows  
- Designing reproducible, scalable environments  

In 2025, I expanded into **GPU‑accelerated model workflows** and multimodal experimentation. That work made something clear:  
**AI infrastructure engineering is the natural evolution of my DevOps background.**

This repository documents my journey to formalize that transition — not through theory, but through a **real, production-style AI system** that demonstrates the skills modern ML platform teams expect.

---

# **🚀 Flagship Project: Public AWS Bedrock Agent**

The centerpiece of this journey is a fully deployed, public-facing AI agent built on **AWS Bedrock**.  
This agent:

- Lives inside a **single‑page web UI**  
- Uses **Bedrock Agents** for orchestration  
- Retrieves information from a **vector knowledge base**  
- Learns from documentation stored in this repo under `/knowledge`  
- Explains its own architecture, pricing, and design decisions  
- Demonstrates real-world **ML engineering**, **DevOps**, and **cloud architecture** skills  
- Is deployed end‑to‑end through **CI/CD pipelines**  

This is not a toy demo — it’s a production‑style system designed to show employers how I think, build, automate, and operate AI infrastructure.

---

# **🎯 What This Repository Demonstrates**

This project focuses on the practical, high‑impact skills that matter in modern AI engineering roles:

### **✔ Serverless AI Agents on AWS Bedrock**  
Designing and deploying a public agent that employers can interact with directly.

### **✔ Retrieval‑Augmented Generation (RAG)**  
Using AWS Bedrock Knowledge Bases backed by S3 to ingest and embed documentation from `/knowledge`.

### **✔ Cost‑Optimized Cloud Architecture**  
Selecting efficient models, storage layers, and serverless components to keep a public agent affordable and reliable.

### **✔ Infrastructure‑as‑Code for AI Systems**  
Defining Bedrock Agents, Knowledge Bases, API Gateway, Lambda, S3, and CloudFront using IaC for reproducibility and clarity.

### **✔ CI/CD Pipelines for AI + Infrastructure**  
Automating deployment of:
- the frontend (SPA),  
- the backend (Lambda/API),  
- and the infrastructure (IaC)  

using GitHub Actions and AWS CodePipeline/CodeBuild.

### **✔ Automated Knowledge Base Synchronization**  
Every commit to `/knowledge` triggers a pipeline that syncs updated Markdown files to S3, enabling automatic re‑indexing.

### **✔ Production‑Style Observability and Operations**  
Logging, metrics, and basic safeguards for a public AI endpoint.

### **✔ Self‑Documenting AI Architecture**  
The agent can explain:
- how it is built,  
- why each AWS service was chosen,  
- how much it costs to run,  
- and how the CI/CD pipeline works  

using the same knowledge base that powers its retrieval.

This project is intentionally scoped to highlight **ML engineering**, **DevOps**, and **cloud architecture** — the intersection where modern AI infrastructure roles live.

---

# **📂 Repository Structure**
```
ai-journey-2026/
│
├── frontend/           # Single-page UI hosting the public agent
├── backend/            # Lambda/API logic for Bedrock Agent Runtime
├── infra/              # IaC for Bedrock Agent, KB, API Gateway, Lambda, S3, CloudFront
│
├── knowledge/          # Source files for the vector Knowledge Base
│   ├── architecture.md
│   ├── costs.md
│   ├── cicd.md
│   ├── model-selection.md
│   ├── design-decisions.md
│   └── agent-philosophy.md
│
├── foundations/        # ML fundamentals, PyTorch, multimodal basics
├── distributed/        # (Optional) Notes on DDP, FSDP, DeepSpeed
├── optimization/       # (Optional) Notes on ONNX, TensorRT, quantization
├── infra-notes/        # MLOps, monitoring, registries, feature stores
├── projects/           # Additional experiments and demos
│
├── notes/              # General technical notes
│
└── README.md           # This file
```

---

# **🏆 Certificates Earned**
This repo tracks all certificates earned along the AWS Machine Learning/Data Scientist Specialty path, including:

- AWS Certified AI Practitioner - Foundational
- AWS Certified Cloud Practitioner - Foundational
- AWS Certified Machine Learning Engineer - Associate
- AWS Certified Solutions Architect - Associate
- AWS Certified Developer - Associate
- AWS Certified Data Engineer - Associate
- AWS Certified Solutions Architect - Professional
- AWS Certified DevOps Engineer - Professional
- AWS Certified Machine Learning - Specialty

A full certificate tracker lives in the wiki.

---

# **📘 Wiki**
The wiki contains the day‑by‑day roadmap, certificate tracker, and progress logs.

---

# **🎯 Goal**
By March 15, 2026, I will be fully prepared to interview for:

- **AI Infrastructure Engineer**  
- **Senior MLOps Engineer**  
- **AI Platform Engineer** 

These roles align directly with my background in DevOps, automation, cloud architecture, and emerging AI workflows — and this project serves as a public, interactive demonstration of those skills.

---
