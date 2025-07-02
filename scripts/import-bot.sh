#!/bin/bash
set -e
TARGET_PROFILE="default"
REGION="us-east-1"
ROLE_ARN_DESTINO="arn:aws:iam::<ID_CONTA_DEST>:role/<ROLE_LEX>"

IMPORT_ID=$(aws lexv2-models start-import \\
  --profile "$TARGET_PROFILE" \\
  --import-idempotency-token "import-$(date +%s)" \\
  --resource-specification botImportSpecification={botName="BotImportado",roleArn="$ROLE_ARN_DESTINO",dataPrivacy={childDirected=false},idleSessionTTLInSeconds=300} \\
  --merge-strategy FailOnConflict \\
  --file-format LexJson \\
  --cli-binary-format raw-in-base64-out \\
  --file-binaries fileb://bot-export.zip \\
  --region "$REGION" | jq -r '.importId')

while true; do
  STATUS=$(aws lexv2-models describe-import --profile "$TARGET_PROFILE" --import-id "$IMPORT_ID" --region "$REGION" --query 'importStatus' --output text)
  echo "Status: $STATUS"
  [[ "$STATUS" == "Completed" ]] && break
  [[ "$STATUS" == "Failed" ]] && echo "❌ Importação falhou." && exit 1
  sleep 5
done