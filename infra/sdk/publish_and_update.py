#!/usr/bin/env python3
import json
import sys
import time
import boto3
import os
import traceback

def log(msg, **fields):
    """Structured log to stderr only."""
    entry = {"msg": msg, **fields}
    print(json.dumps(entry), file=sys.stderr)

def fail(msg, **fields):
    """Fail with structured error to stderr, then exit."""
    entry = {"error": msg, **fields}
    print(json.dumps(entry), file=sys.stderr)
    sys.exit(1)

def main():
    # -----------------------------
    # Read environment
    # -----------------------------
    agent_id = os.environ.get("AGENT_ID")
    alias_id = os.environ.get("ALIAS_ID") or ""
    region = os.environ.get("AWS_REGION", "us-east-1")

    log("Starting publish_and_update.py", agent_id=agent_id, alias_id=alias_id, region=region)

    if not agent_id:
        fail("Missing AGENT_ID environment variable")

    try:
        client = boto3.client("bedrock-agent", region_name=region)
        log("Created boto3 Bedrock Agent client")
    except Exception as e:
        fail("Failed to create boto3 client", exception=str(e), traceback=traceback.format_exc())

    resp = None
    for attempt in range(1, 4):
        try:
            log("Attempting publish_agent_version", attempt=attempt)
            resp = client.publish_agent_version(agentId=agent_id)
            log("Publish succeeded", response=resp)
            break
        except Exception as e:
            log("Publish attempt failed", attempt=attempt, exception=str(e), traceback=traceback.format_exc())
            if attempt == 3:
                fail("Publish failed after retries", last_exception=str(e))
            time.sleep(5 * attempt)

    # -----------------------------
    # Extract version
    # -----------------------------
    version = None
    try:
        version = resp.get("agentVersion", {}).get("version")
    except Exception as e:
        fail("Failed to extract version from publish response", exception=str(e), raw_response=resp)

    if not version:
        fail("Publish returned no version", raw_response=resp)

    log("Extracted published version", version=version)

    result = {
        "published_version": version,
        "publish_response": resp
    }

    if alias_id:
        try:
            log("Updating alias", alias_id=alias_id, version=version)
            upd = client.update_agent_alias(
                agentId=agent_id,
                agentAliasId=alias_id,
                routingConfiguration={"agentVersion": version}
            )
            log("Alias update succeeded", update_response=upd)
            result["update_alias_response"] = upd
        except Exception as e:
            log("Alias update failed", exception=str(e), traceback=traceback.format_exc())
            result["alias_update_error"] = str(e)

    # IMPORTANT: Only ONE JSON object printed to stdout
    print(json.dumps(result))

if __name__ == "__main__":
    main()