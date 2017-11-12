Role Name
=========

etcd

Устанавливает etcd. Если в группе k8s_master будет более одного хоста - установит кластер.
При установке генерируются самоподписанные ssl сертификаты.


Role Variables
--------------

	etcd_version: "3.1.9"

	etcd_client_port: 2379
	etcd_peer_port: 2380
	etcd_machine_address: "{{ hostvars[inventory_hostname].ansible_default_ipv4.address }}"

	etcd_data_dir: /var/lib/etcd
	etcd_certs_dir: "/etc/etcd/certs"
	etcd_script_dir: /usr/libexec/etcd

	etcd_initial_cluster_state: new
	etcd_initial_cluster_token: etcd-k8-cluster

	container: false


Example Playbook
----------------

    - hosts: k8s_master
      roles:
         - etcd

Author Information
------------------

al.kashtan.ex@gmail.com