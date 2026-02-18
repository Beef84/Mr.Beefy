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

# Check if the KB is already associated
$EXISTS = aws bedrock-agent list-agent-knowledge-bases `
  --agent-id $AgentId `
  --agent-version $AGENT_VERSION `
  --query "agentKnowledgeBaseSummaries[?knowledgeBaseId=='$KbId'] | length(@)" `
  --output text

if ($EXISTS -eq 1) {
    Write-Host "Knowledge Base $KbId is already associated with agent $AgentId. Skipping."
    exit 0
}

Write-Host "Associating Knowledge Base $KbId with agent $AgentId..."

# Attempt association
try {
    aws bedrock-agent associate-agent-knowledge-base `
      --agent-id $AgentId `
      --agent-version $AGENT_VERSION `
      --knowledge-base-id $KbId `
      --description "Primary KB association for mrbeefy agent" `
      --knowledge-base-state ENABLED

    Write-Host "KB association completed."
}
catch {
    Write-Error "KB association failed: $($_.Exception.Message)"
    exit 1
}