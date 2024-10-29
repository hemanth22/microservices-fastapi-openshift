#!/bin/bash

# Read the value from the environment variable and encode it in base64
SECRET_VALUE1=$(echo -n "${telegram_api_key}" | base64)
SECRET_VALUE2=$(echo -n "${telegram_id}" | base64)

# Generate the secret YAML
cat <<EOF > ${OPENSHIFT_SECRET_NAME1}.yaml
apiVersion: v1
kind: Secret
metadata:
  name: $OPENSHIFT_SECRET_NAME1
  namespace: $OPENSHIFT_NAMESPACE
type: Opaque
data:
  telegram_api_key: $SECRET_VALUE1
  telegram_id: $SECRET_VALUE2
EOF

echo "YAML file '${OPENSHIFT_SECRET_NAME1}.yaml' created successfully."
echo "Apply it using: kubectl apply -f ${OPENSHIFT_SECRET_NAME1}.yaml"