param(
  [string]$KbId
)

# Always set region explicitly so ingestion doesn't break in CI
$env:AWS_REGION = "us-east-1"
$env:AWS_DEFAULT_REGION = "us-east-1"

# Fetch the data source ID automatically
$DataSourceId = aws bedrock-agent list-data-sources `
  --knowledge-base-id $KbId `
  --query "dataSourceSummaries[0].dataSourceId" `
  --output text

if (-not $DataSourceId -or $DataSourceId -eq "" -or $DataSourceId -eq "None") {
    Write-Error "No data source found for KB $KbId"
    exit 1
}

# Start ingestion job
aws bedrock-agent start-ingestion-job `
  --knowledge-base-id $KbId `
  --data-source-id $DataSourceId