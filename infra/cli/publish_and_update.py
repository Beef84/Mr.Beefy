#!/usr/bin/env python3
# infra/cli/publish_and_update.py
# Usage: python publish_and_update.py <agent_id> <alias_id> [region]

import sys, json
import boto3
from botocore.exceptions import ClientError

if len(sys.argv) < 3:
    print(json.dumps({"error":"usage: publish_and_update.py <agent_id> <alias_id> [region]"}))
    sys.exit(2)

agent_id = sys.argv[1]
alias_id = sys.argv[2]
region = sys.argv[3] if len(sys.argv) > 3 else "us-east-1"

client = boto3.client("bedrock-agent", region_name=region)

try:
    pub = client.publish_agent_version(agentId=agent_id)
    version = pub.get("agentVersion", {}).get("version")
    if not version:
        print(json.dumps({"error":"no version returned"}))
        sys.exit(3)

    client.update_agent_alias(
        agentId=agent_id,
        agentAliasId=alias_id,
        routingConfiguration=[{"agentVersion": str(version)}]
    )

    print(json.dumps({"version": str(version)}))
    sys.exit(0)

except ClientError as e:
    print(json.dumps({"error": str(e)}))
    sys.exit(4)