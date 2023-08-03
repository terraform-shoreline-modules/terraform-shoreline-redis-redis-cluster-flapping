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