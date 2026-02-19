#!/usr/bin/env python3
# infra/cli/publish_and_update.py
# Usage: python publish_and_update.py <agent_id> <alias_id> [region]
# Tries boto3 publish_agent_version; if not available, falls back to AWS CLI.

import sys
import json
import subprocess
import shlex

def out_json(obj):
    print(json.dumps(obj, ensure_ascii=False))
    sys.stdout.flush()

if len(sys.argv) < 3:
    out_json({"error":"usage: publish_and_update.py <agent_id> <alias_id> [region]"})
    sys.exit(2)

agent_id = sys.argv[1]
alias_id = sys.argv[2]
region = sys.argv[3] if len(sys.argv) > 3 else "us-east-1"

# Try boto3 first
try:
    import boto3
    from botocore.exceptions import ClientError, NoRegionError, NoCredentialsError

    client = boto3.client("bedrock-agent", region_name=region)
    # Defensive check: does the client have the operation?
    ops = []
    try:
        ops = client.meta.service_model.operation_names
    except Exception:
        ops = []

    if "PublishAgentVersion" in ops or "publish_agent_version" in [o.lower() for o in ops]:
        try:
            pub = client.publish_agent_version(agentId=agent_id)
            version = pub.get("agentVersion", {}).get("version")
            if not version:
                out_json({"error":"boto3 publish returned no version", "raw": pub})
                sys.exit(3)

            client.update_agent_alias(
                agentId=agent_id,
                agentAliasId=alias_id,
                routingConfiguration=[{"agentVersion": str(version)}]
            )

            out_json({"version": str(version), "method":"boto3"})
            sys.exit(0)
        except ClientError as e:
            out_json({"error":"boto3 ClientError", "detail": str(e)})
            sys.exit(4)
    else:
        # boto3 client exists but operation not present
        # fall through to CLI fallback
        pass

except (ImportError, NoCredentialsError) as e:
    # boto3 not installed or credentials missing; fall back to CLI
    pass
except Exception as e:
    # Unexpected boto3 error; include it in logs and fall back to CLI
    pass

# Fallback: use AWS CLI (must be installed in runner)
# Use subprocess and parse JSON output
def run_cli(cmd):
    try:
        proc = subprocess.run(shlex.split(cmd), capture_output=True, text=True)
        return proc.returncode, proc.stdout.strip(), proc.stderr.strip()
    except Exception as e:
        return 2, "", str(e)

# Publish via CLI
publish_cmd = f"aws bedrock-agent publish-agent-version --region {shlex.quote(region)} --agent-id {shlex.quote(agent_id)} --output json"
rc, out, err = run_cli(publish_cmd)
if rc != 0:
    out_json({"error":"CLI publish failed", "rc": rc, "stderr": err, "stdout": out})
    sys.exit(5)

try:
    pub = json.loads(out)
    version = pub.get("agentVersion", {}).get("version")
    if not version:
        out_json({"error":"CLI publish returned no version", "raw": pub})
        sys.exit(6)
except Exception as e:
    out_json({"error":"failed to parse CLI publish output", "exception": str(e), "stdout": out, "stderr": err})
    sys.exit(7)

# Update alias via CLI
# routing-configuration expects JSON array; pass as string
routing = json.dumps([{"agentVersion": str(version)}], separators=(",", ":"))
update_cmd = f"aws bedrock-agent update-agent-alias --region {shlex.quote(region)} --agent-id {shlex.quote(agent_id)} --agent-alias-id {shlex.quote(alias_id)} --routing-configuration '{routing}'"
rc2, out2, err2 = run_cli(update_cmd)
if rc2 != 0:
    out_json({"error":"CLI update-agent-alias failed", "rc": rc2, "stderr": err2, "stdout": out2, "version": version})
    sys.exit(8)

out_json({"version": str(version), "method":"aws-cli"})
sys.exit(0)