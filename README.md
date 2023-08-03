
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Redis cluster flapping incident.
---

A Redis cluster flapping incident occurs when changes are detected in the Redis replica connection. This can happen when replica nodes lose connection to the master and reconnect repeatedly. This can lead to unstable performance and can impact the stability of the Redis cluster.

### Parameters
```shell
# Environment Variables

export REDIS_HOST="PLACEHOLDER"

export REDIS_PORT="PLACEHOLDER"

export REDIS_LOG_FILE="PLACEHOLDER"

export REPLICA_NODE="PLACEHOLDER"

export MASTER_NODE="PLACEHOLDER"

```

## Debug

### Get the Redis cluster status
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} cluster nodes
```

### Get the Redis cluster configuration
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} cluster info
```

### Check if all Redis nodes are connected
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} cluster check
```

### Check the Redis replication status
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info replication
```

### Check the Redis logs for any errors
```shell
tail -f ${REDIS_LOG_FILE}
```

### Check the Redis memory usage
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info memory
```

### Check the Redis CPU usage
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info cpu
```

### Check the Redis keyspace stats
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info keyspace
```

### Check the Redis client connections
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} client list
```

### Check the network connectivity between Redis nodes
```shell
ping ${REDIS_HOST}
```

### Check the network latency between Redis nodes
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} --latency
```

### Check the network bandwidth between Redis nodes
```shell
iperf -c ${REDIS_HOST} -p ${REDIS_PORT} -t 60 -i 10
```
## Repair

### Restart the Redis nodes one by one, starting with the replica nodes, to see if it resolves the issue.
```shell
#!/bin/bash

# Define the Redis nodes

REDIS_REPLICA_NODE=${REPLICA_NODE}

REDIS_MASTER_NODE=${MASTER_NODE}

# Restart the Redis replica nodes

for node in $REDIS_REPLICA_NODE; do

  ssh $node "sudo systemctl restart redis"

done

# Restart the Redis master node

ssh $REDIS_MASTER_NODE "sudo systemctl restart redis"

```