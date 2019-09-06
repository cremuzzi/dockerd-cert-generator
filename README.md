# Dockerd PKI Helpers

a collection of scripts to help with the creation of a CA, server and client keys with OpenSSL.

Based on the official Docker [documentation](https://docs.docker.com/engine/security/https/).

## Key generation for your CA

```
sh ca-generator.sh
```

## Key generation for a Server

```
sh server-generator.sh <server-hostname> <server-ip>
```

## Key generation for a Client

```
sh client-generator.sh <client-hostname> <client-ip>
```
