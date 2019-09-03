#!/usr/bin/env sh

set -e

TARGET_HOST=$1
TARGET_IP=$2
TARGET_DIR="${PWD}/${TARGET_HOST}"
CA_PATH="${PWD}/ca"

mkdir -p ${TARGET_DIR}

echo "copying ca.pem to ${TARGET_DIR}..."
cp ${CA_PATH}/ca.pem ${TARGET_DIR}
echo "setting up client certs..."
openssl genrsa -out ${TARGET_DIR}/server-key.pem 4096
openssl req -subj "/CN=${TARGET_HOST}" -sha256 -new -key ${TARGET_DIR}/server-key.pem -out /tmp/server.csr
echo subjectAltName = DNS:${TARGET_HOST},IP:${TARGET_IP},IP:127.0.0.1 >> /tmp/extfile.cnf
echo extendedKeyUsage = serverAuth >> /tmp/extfile.cnf
openssl x509 -req -days 365 -sha256 -in /tmp/server.csr -CA ${CA_PATH}/ca.pem -CAkey ${CA_PATH}/ca-key.pem -CAcreateserial -out ${TARGET_DIR}/server-cert.pem -extfile /tmp/extfile.cnf
echo "certs generated in ${TARGET_DIR} :"
ls -la ${TARGET_DIR}
