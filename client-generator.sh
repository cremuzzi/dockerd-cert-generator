#!/usr/bin/env sh

set -e

TARGET_HOST=$1
TARGET_DIR="${PWD}/${TARGET_HOST}"
CA_PATH="${PWD}/ca"

mkdir -p ${TARGET_DIR}

echo "copying ca.pem to ${TARGET_DIR}..."
cp ${CA_PATH}/ca.pem ${TARGET_DIR}
echo "setting up client certs..."
openssl genrsa -out ${TARGET_DIR}/key.pem 4096
echo extendedKeyUsage = clientAuth > /tmp/extfile-client.cnf
openssl req -subj '/CN=client' -new -key ${TARGET_DIR}/key.pem -out /tmp/client.csr
openssl x509 -req -days 365 -sha256 -in /tmp/client.csr -CA ${CA_PATH}/ca.pem -CAkey ${CA_PATH}/ca-key.pem -CAcreateserial -out ${TARGET_DIR}/cert.pem -extfile /tmp/extfile-client.cnf
echo "certs generated in ${TARGET_DIR} :"
ls -la ${TARGET_DIR}
