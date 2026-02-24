- CloudFront terminates TLS  
- API Gateway enforces HTTPS  
- No public S3 access  
- No public KB access  
- No public Lambda URLs  

---

## **4.3 Data Governance**
- KB files are stored in S3 with restricted access  
- Vector store is fully managed by Bedrock  
- No PII or sensitive data is stored in logs  
- No user messages are persisted outside CloudWatch logs  

---

# **5. Operational Governance**

## **5.1 Logging**
- Lambda logs are required  
- API Gateway access logs are required  
- API Gateway execution logs are required  
- CloudFront logs are optional but recommended  

Logs must not contain:

- Secrets  
- Credentials  
- AWS account identifiers  
- Sensitive personal data  

---

## **5.2 Monitoring**
Monitoring includes:

- Lambda error rates  
- API Gateway 4xx/5xx rates  
- CloudFront cache hit/miss ratios  
- KB ingestion job status  
- Bedrock agent invocation metrics  

Alerts may be added as the system scales.

---

## **5.3 Deployment Governance**
Deployments must:

- Run through CI/CD  
- Use versioned artifacts  
- Produce deterministic infrastructure  
- Avoid manual console changes  

Manual console edits are only allowed for:

- Emergency rollback  
- Temporary debugging  
- AWS support troubleshooting  
