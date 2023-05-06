## Cassandra cluster on docker-compose with monitoring

This repo has a docker-compose file to spin up a 3-node Cassandra cluster for learning purposes.

### Requirements
When all three nodes are run, Docker used ~15 GB of memory on MacBook. You can run one or two nodes with lesser memory.

### Learning purposes only
The docker-compose setup creates volumes and networks which would get removed if `docker-compose down -v` is run, resulting in loss of any stored data. This
setup is for the purpose of learning the Cassandra cluster mechanics only.

### Cassandra Docker image
docker-compose file uses the Dockerfile in this repo to build a Cassandra image that has a Cassandra Prometheus exporter. This allows export of Cassandra metrics in Prometheus format and allows monitoring.

Repository used for this is https://github.com/instaclustr/cassandra-exporter

### Bringing up the cluster
Though all the services are mentioned in docker-compose, when all of them are brought up together with `docker-compose up -d`, I saw that one or the other nodes crashed or didn't become a part of the ring. So the steps are as follows - 

1. Bring up first node, Grafana and Prometheus - `docker-compose up -d node0 grafana prom`
1. Run `docker exec node0 nodetool status`, once you see the status as `UN` (Up and Normal) and Owns as `100%`
1. Bring up second node with `docker-compose up -d node1`
1. Wait until the execution of `docker exec node0 nodetool status` shows both nodes as `UN` and Ownership is split.
1. Bring up the third node with `docker-compose up -d node2`
1. Wait until the execution of `docker exec node0 nodetool status` shows all three nodes as `UN` and Ownership is further split.

After all three nodes are brought up, the `nodetool status` shows something similar as - 
```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load        Tokens  Owns (effective)  Host ID                               Rack
UN  172.18.0.6  75.2 KiB    16      76.0%             23966d83-4c46-46f6-b4a1-38a9d8f53de3  rack1
UN  172.18.0.2  109.39 KiB  16      64.7%             ee60e784-46b3-42ca-b890-757b0ea63ed3  rack1
UN  172.18.0.5  70.24 KiB   16      59.3%             7db96b60-9733-46e6-8c9f-87d935163ec6  rack1
```

### Notes
The `notes` directory has some notes about the Cluster