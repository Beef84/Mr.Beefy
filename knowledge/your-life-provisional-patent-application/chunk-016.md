                                 | Raw Media
                                 v
                        +-----------------------+
                        | Transcription Module  |
                        +-----------------------+
                                 |
                                 | Transcript
                                 v
                        +-----------------------+
                        | Content Processor     |
                        | - Chunking            |
                        | - Metadata Extraction |
                        | - Summaries/Tags      |
                        +-----------------------+
                                 |
                                 | Clean Text
                                 v
                        +-----------------------+
                        | Embedding Generator   |
                        +-----------------------+
                                 |
                                 | Embeddings
                                 v
        +--------------------------------+     +------------------------------+
        | Vector Index (Tenant Scoped)   |     | Relational DB (Metadata)     |