#!/bin/sh
set -e

# 1.使用 genrsa 命令生成密钥长度为 2048 比特的 RSA 密钥对
openssl genrsa \
  -out ca-key.pem 2048

# 2.使用私钥（ca-key.pem）生成 CSR ca.pem）
openssl req \
  -x509 \
  -new \
  -nodes \
  -key ca-key.pem \
  -days 3560 \
  -extensions v3_ca \
  -out ca.pem \
  -subj "/O=Kubernetes"

openssl x509 -in ca.pem -text

openssl genrsa \
  -out key.pem 2048

openssl req \
  -new \
  -key key.pem \
  -out csr.pem \
  -subj "/O=Kubernetes/CN=*.example.com"

openssl x509 \
  -req \
  -in csr.pem \
  -CA ca.pem \
  -CAkey ca-key.pem \
  -CAcreateserial \
  -out cert.pem \
  -extensions v3_ca \
  -extfile ssl-extensions-x509.cnf \
  -days 3560

openssl x509 -in cert.pem -text

rm ca.srl
rm csr.pem