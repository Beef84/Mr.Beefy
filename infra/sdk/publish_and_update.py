#!/usr/bin/env python3
import json
import sys
import time
import boto3
import os

def main():
    agent_id = os.environ.get("AGENT_ID")
    alias_id = os.environ.get("ALIAS_ID") or ""
    region = os.environ.get("AWS_REGION", "us-east-1")

    if not agent_id:
        print(json.dumps({"error": "Missing AGENT_ID"}))
        sys.exit(2)

    client = boto3.client("bedrock-agent", region_name=region)

    # Retry publish
    resp = None
    for attempt in range(1, 4):
        try:
            resp = client.publish_agent_version(agentId=agent_id)
            break
        except Exception as e:
            if attempt == 3:
                print(json.dumps({"error": str(e)}))
                sys.exit(1)
            time.sleep(5 * attempt)

    version = resp.get("agentVersion", {}).get("version")
    if not version:
        print(json.dumps({"error": "No version returned", "raw": resp}))
        sys.exit(1)

    result = {"published_version": version, "publish_response": resp}

    # Update alias if provided
    if alias_id:
        try:
            upd = client.update_agent_alias(
                agentId=agent_id,
                agentAliasId=alias_id,
                routingConfiguration={"agentVersion": version}
            )
            result["update_alias_response"] = upd
        except Exception as e:
            result["alias_update_error"] = str(e)

    print(json.dumps(result))
    sys.exit(0)

if __name__ == "__main__":
    main()