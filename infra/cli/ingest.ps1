param(
  [string]$KbId,
  [string]$DataSourceId
)

aws bedrock-agent start-ingestion-job `
  --knowledge-base-id $KbId `
  --data-source-id $DataSourceId