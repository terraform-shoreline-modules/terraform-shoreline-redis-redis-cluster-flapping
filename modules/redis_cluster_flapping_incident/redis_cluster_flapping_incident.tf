resource "shoreline_notebook" "redis_cluster_flapping_incident" {
  name       = "redis_cluster_flapping_incident"
  data       = file("${path.module}/data/redis_cluster_flapping_incident.json")
  depends_on = [shoreline_action.invoke_redis_restart_nodes]
}

resource "shoreline_file" "redis_restart_nodes" {
  name             = "redis_restart_nodes"
  input_file       = "${path.module}/data/redis_restart_nodes.sh"
  md5              = filemd5("${path.module}/data/redis_restart_nodes.sh")
  description      = "Restart the Redis nodes one by one, starting with the replica nodes, to see if it resolves the issue."
  destination_path = "/agent/scripts/redis_restart_nodes.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_redis_restart_nodes" {
  name        = "invoke_redis_restart_nodes"
  description = "Restart the Redis nodes one by one, starting with the replica nodes, to see if it resolves the issue."
  command     = "`chmod +x /agent/scripts/redis_restart_nodes.sh && /agent/scripts/redis_restart_nodes.sh`"
  params      = ["REPLICA_NODE","MASTER_NODE"]
  file_deps   = ["redis_restart_nodes"]
  enabled     = true
  depends_on  = [shoreline_file.redis_restart_nodes]
}

