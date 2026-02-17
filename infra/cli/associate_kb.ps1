param(
  [string]$AgentId,
  [string]$KbId
)

aws bedrock-agent associate-agent-knowledge-base `
  --agent-id $AgentId `
  --knowledge-base-id $KbId `
  --description "Primary KB for Mr. Beefy"