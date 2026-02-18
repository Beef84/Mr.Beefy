param(
  [string]$KbId
)

# Fetch the data source ID automatically
$DataSourceId = aws bedrock-agent list-data-sources `
  --knowledge-base-id $KbId `
  --query "dataSourceSummaries[0].dataSourceId" `
  --output text

if (-not $DataSourceId -or $DataSourceId -eq "None") {
    Write-Error "No data source found for KB $KbId"
    exit 1
}

aws bedrock-agent start-ingestion-job `
  --knowledge-base-id $KbId `
  --data-source-id $DataSourceId