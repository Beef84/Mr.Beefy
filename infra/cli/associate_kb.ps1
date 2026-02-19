param(
  [string]$AgentId,
  [string]$KbId
)

# Get the latest published agent version
$AGENT_VERSION = aws bedrock-agent list-agent-versions `
  --agent-id $AgentId `
  --query "agentVersionSummaries[-1].agentVersion" `
  --output text

if (-not $AGENT_VERSION -or $AGENT_VERSION -eq "None") {
    Write-Host "No published versions found. Cannot associate KB to DRAFT for production."
    exit 1
}

Write-Host "Using Published Agent Version: $AGENT_VERSION"

# Check if the KB is already associated
$EXISTS = aws bedrock-agent list-agent-knowledge-bases `
  --agent-id $AgentId `
  --agent-version $AGENT_VERSION `
  --query "agentKnowledgeBaseSummaries[?knowledgeBaseId=='$KbId'] | length(@)" `
  --output text

if ($EXISTS -eq 1) {
    Write-Host "Knowledge Base $KbId is already associated with agent version $AGENT_VERSION. Skipping."
    exit 0
}

Write-Host "Associating Knowledge Base $KbId with agent version $AGENT_VERSION..."

aws bedrock-agent associate-agent-knowledge-base `
  --agent-id $AgentId `
  --agent-version $AGENT_VERSION `
  --knowledge-base-id $KbId `
  --description "Primary KB association for mrbeefy agent" `
  --knowledge-base-state ENABLED

Write-Host "KB association completed."