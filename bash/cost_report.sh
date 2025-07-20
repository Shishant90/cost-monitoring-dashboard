#!/bin/bash

START_DATE="${1:-2025-07-01}"
END_DATE="${2:-2025-07-13}"
GRANULARITY="${3:-DAILY}"
METRICS="${4:-UnblendedCost}"
BUCKET="${5:-shishant}"

FILENAME="cost-report-$(date +%Y-%m-%d-%H-%M-%S).txt"

# Generate cost report from AWS CLI
aws ce get-cost-and-usage \
    --time-period Start=$START_DATE,End=$END_DATE \
    --granularity $GRANULARITY \
    --metrics $METRICS \
    --output table > "$FILENAME"

# Upload to S3 bucket
aws s3 cp "$FILENAME" "s3://$BUCKET/reports/$FILENAME"

echo "Report uploaded: s3://$BUCKET/reports/$FILENAME"

# Optional: Clean up local file
rm "$FILENAME"