#!/bin/bash

workflow_file="Workflow_with_inputs.wdl"
cromwell_url="http://localhost:8000"
total_workflows=200

start_time=$(date +%s)

json_input_file=$(mktemp)


# Generate JSON input for batch submission and write to the specified file
echo '[' > "$json_input_file"
for ((i=1; i<=total_workflows; i++)); do
    if [ $i -gt 1 ]; then
        echo ',' >> "$json_input_file"  # Add comma except for the first object
    fi
    echo '{"myWorkflow1Task.name": "john"}' >> "$json_input_file"  # Add input data for each workflow
done
echo ']' >> "$json_input_file"



# Submit batch of workflows
response=$(curl --max-time 300 -X POST --header "Accept: application/json" -F "workflowSource=@${workflow_file}" -F "workflowInputs=@${json_input_file}" "${cromwell_url}/api/workflows/v1/batch")

array_length=$(echo "$response" | jq length)

echo "Number of jobs submitted: $array_length"

# Extract workflow IDs from the response
workflow_ids=()
for workflow_status in $(echo "$response" | jq -r '.[].id'); do
    workflow_ids+=("$workflow_status")
done

# Wait for all workflows to finish
while true; do
    all_finished=true
    for workflow_id in "${workflow_ids[@]}"; do
        status_response=$(curl -s "${cromwell_url}/api/workflows/v1/${workflow_id}/status")
        status=$(echo $status_response | jq -r '.status')
        if [[ "$status" != "Succeeded" && "$status" != "Failed" ]]; then
            all_finished=false
            break
        fi
    done

    if $all_finished; then
        echo "All workflows finished."
        break
    fi

done