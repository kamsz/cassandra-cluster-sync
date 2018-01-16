#!/bin/bash

set -x

if [[ ! -d "/data" ]]
then
  mkdir /data
fi

keyspaces=($(cqlsh ${CLUSTER_FROM} -e "desc keyspaces;"))

for keyspace in ${keyspaces[@]};
do
  if [[ ${keyspace} =~ ^(system_schema|system_traces|system_auth|system|system_distributed)$ ]]
  then
    continue
  fi

  cqlsh ${CLUSTER_FROM} -e "desc keyspace ${keyspace};" > schema.cql
  cqlsh ${CLUSTER_TO} -e "drop keyspace ${keyspace};"
  cqlsh ${CLUSTER_TO} -f schema.cql
  HOST=${CLUSTER_FROM} KEYSPACE=${keyspace} node /export.js
  HOST=${CLUSTER_TO} KEYSPACE=${keyspace} node /import.js
  rm -rf /data/*
done
