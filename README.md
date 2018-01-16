Sync data between two Cassandra clusters.

This container will grab all keyspaces (except for system keyspaces) from source cluster and transfer the data to the target cluster.

It is based on https://github.com/masumsoft/cassandra-exporter.

## Building

```
docker build -t cassandra-cluster-sync .
```

## Usage

```
docker run --rm -e CLUSTER_FROM=hostname_of_source_cluster -e CLUSTER_TO=hostname_of_target_cluster kamsz/cassandra-cluster-sync
```
