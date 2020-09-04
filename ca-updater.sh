#!/usr/bin/env sh

set -e

TARGET_DIR="${PWD}/ca"

echo "moving current ca.pem to backup ..."
mv ${TARGET_DIR}/ca.pem ${TARGET_DIR}/old.ca.pem.bak

echo "regenerating ca cert inside ${TARGET_DIR}..."
openssl req -new -x509 -days 365 -key ${TARGET_DIR}/ca-key.pem -sha256 -out ${TARGET_DIR}/ca.pem

ls -la ${TARGET_DIR}
