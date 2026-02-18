param(
  [string]$AgentId,
  [string]$KbId
)

# Get the current agent version
$AGENT_VERSION = aws bedrock-agent get-agent `
  --agent-id $AgentId `
  --query "agent.agentVersion" `
  --output text

Write-Host "Using Agent Version: $AGENT_VERSION"

aws bedrock-agent associate-knowledge-base `
  --agent-id $AgentId `
  --agent-version $AGENT_VERSION `
  --knowledge-base-id $KbId