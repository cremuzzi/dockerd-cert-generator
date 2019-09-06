#!/usr/bin/env sh

set -e

TARGET_DIR="${PWD}/ca"

mkdir -p ${TARGET_DIR}

echo "generating ca key inside ${TARGET_DIR}..."
openssl genrsa -aes256 -out ${TARGET_DIR}/ca-key.pem 4096

echo "generating ca cert inside ${TARGET_DIR}..."
openssl req -new -x509 -days 365 -key ${TARGET_DIR}/ca-key.pem -sha256 -out ${TARGET_DIR}/ca.pem

ls -la ${TARGET_DIR}
