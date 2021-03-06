### Generate Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  k8s_primary_master = var.calico_nodes[0]
  k8s_master_replicas = slice(var.calico_nodes, 1, 3)
  k8s_workers = slice(var.calico_nodes, 3, length(var.calico_nodes))
 }
 )
 filename = "../ansible/inventory/nodes.ini"
}

### Generate Ansible config file
resource "local_file" "AnsibleConfig" {
 content = templatefile("group_var_template.tmpl",
 {
     k8s_cluster = var.k8s_cluster
     as = var.l3out.local_as
     bgp_pass = var.l3out.bgp_pass
     anchor_nodes = var.l3out.anchor_nodes
 }
 )
 filename = "../ansible/inventory/group_vars/all.yml"
}