HTTP APIs do not expose stages in the URL by default.  
To maintain clean frontend URLs, CloudFront uses:

```
origin_path = "/prod"
```

This maps:

```
/chat → /prod/chat
```

without exposing stage names to the user.

---

# **4. CloudFront Design Decisions**

## **4.1 CloudFront as the Routing Layer**
CloudFront was chosen to:

- Serve static assets globally  
- Terminate TLS  
- Route `/chat` to API Gateway  
- Apply security headers  
- Enforce caching policies  
- Protect S3 via OAC  

## **4.2 Two-Origin Architecture**
CloudFront uses:

1. **S3 Origin**  
   - For static frontend assets  
   - Protected by OAC  
   - No public access  

2. **API Gateway Origin**  
   - For dynamic `/chat` requests  
   - Uses HTTPS-only  
   - Uses origin_path to map to stage  

## **4.3 Behavior Design**
- Default behavior → S3  
- Ordered behavior → `/chat` → API Gateway  

This ensures:

- The SPA loads instantly  
- API calls bypass caching  
- Only the intended path hits the backend  

---

# **5. Lambda Design Decisions**

## **5.1 Node.js 20 Runtime**
Chosen for:

- Fast cold starts  
- Native AWS SDK v3 support  
- Simple JSON handling  
- Lightweight deployment package  

## **5.2 Minimal Responsibility**
Lambda does not:

- Perform retrieval  