#!/bin/bash

# Read the value from the environment variable and encode it in base64
SECRET_VALUE1=$(echo -n "${BOOTSTRAP_SERVER_NAME}" | base64 | tr -d '\n\r')
SECRET_VALUE2=$(echo -n "${FASTAPI_WEBHOOK_SERVER}" | base64 | tr -d '\n\r')
SECRET_VALUE3=$(echo -n "${FASTAPI_WEBHOOK_SERVERLESS}" | base64 | tr -d '\n\r')
SECRET_VALUE4=$(echo -n "${SASL_MECH}" | base64 | tr -d '\n\r')
SECRET_VALUE5=$(echo -n "${SASL_PASSD}" | base64 | tr -d '\n\r')
SECRET_VALUE6=$(echo -n "${SASL_USERNAME}" | base64 | tr -d '\n\r')
SECRET_VALUE7=$(echo -n "${SSL_SEC}" | base64 | tr -d '\n\r')


# Generate the secret YAML
cat <<EOF > ${OPENSHIFT_SECRET_NAME2}.yaml
apiVersion: v1
kind: Secret
metadata:
  name: $OPENSHIFT_SECRET_NAME2
  namespace: $OPENSHIFT_NAMESPACE
type: Opaque
data:
  BOOTSTRAP_SERVER_NAME: $SECRET_VALUE1
  FASTAPI_WEBHOOK_SERVER: $SECRET_VALUE2
  FASTAPI_WEBHOOK_SERVERLESS: $SECRET_VALUE3
  SASL_MECH: $SECRET_VALUE4
  SASL_PASSD: $SECRET_VALUE5
  SASL_USERNAME: $SECRET_VALUE6
  SSL_SEC: $SECRET_VALUE7
EOF

echo "YAML file '${OPENSHIFT_SECRET_NAME2}.yaml' created successfully."
echo "Apply it using: kubectl apply -f ${OPENSHIFT_SECRET_NAME2}.yaml"