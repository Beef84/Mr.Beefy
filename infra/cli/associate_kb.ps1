param(
  [string]$AgentId,
  [string]$KbId
)

# Get the current agent version
$AGENT_VERSION = aws bedrock-agent get-agent `
  --agent-id $AgentId `
  --query "agent.agentVersion" `
  --output text

if (-not $AGENT_VERSION -or $AGENT_VERSION -eq "None") {
    $AGENT_VERSION = "DRAFT"
}

Write-Host "Using Agent Version: $AGENT_VERSION"

aws bedrock-agent associate-agent-knowledge-base `
  --agent-id $AgentId `
  --agent-version $AGENT_VERSION `
  --knowledge-base-id $KbId `
  --description "Primary KB association for mrbeefy agent" `
  --knowledge-base-state ENABLED