Role Name
=========

flannel

Role Variables
--------------

	flannel_version: "0.7.1"
	cluster_name: "cluster.lan"

	etcd_client_port: 2379

	flannel_subnet: 172.96.0.0
	flannel_prefix: 12
	flannel_host_prefix: 24
	flannel_backend: vxlan

	flannel_etcd_certs_dir: "/etc/flanneld/certs"
	flannel_etcd_ca_file: "{{ flannel_etcd_certs_dir }}/ca.crt"
	flannel_etcd_cert_file: "{{ flannel_etcd_certs_dir }}/client.crt"
	flannel_etcd_key_file: "{{ flannel_etcd_certs_dir }}/client.key"

	etcd_ca_file: "/etc/etcd/certs/ca.crt"
	etcd_client_cert_file: "/etc/etcd/certs/client.crt"
	etcd_client_key_file: "/etc/etcd/certs/client.key"

Dependencies
------------

etcd

Example Playbook
----------------

    - hosts: k8s_master
      roles:
         - flannel

Author Information
------------------

al.kashtan.ex@gmail.com