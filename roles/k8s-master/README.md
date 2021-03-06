Role Name
=========

kubernetes-master

Устанавливает кластер kubernetes с ssl.
При наличии нескольких хостов в группе k8s_master - будет установлен multi-master, поверх которого можно поставить haproxy.

Авторизация которая настраивается: http basic, по токенам, по сертификатам. RBAC нет, это нужно учесть при деплое (не деплоить роли и их привязку).

Базово, любые поды внутри кластера считаются авторизованными. Т.е. аккаунты им не нужны, кроме тех которые обращаются к api.


Role Variables
--------------

	kube_rpm_url_base: "https://kojipkgs.fedoraproject.org/packages/kubernetes/1.8.1/1.fc28/x86_64/"
	kube_rpm_url_sufix: "1.8.1-1.fc28.x86_64.rpm"

	kube_cert_ip: "{{ hostvars[inventory_hostname]['ansible_all_ipv4_addresses']|join (',') }}"
	kube_master_api_port: 6443
	kube_apiserver_bind_address: "0.0.0.0"
	kube_service_addresses: "172.30.0.0/16"
	admission_controllers: "Initializers,NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,ResourceQuota"

	kube_script_dir: '/usr/libexec/kubernetes'
	kube_config_dir: /etc/kubernetes
	kube_cert_dir: "{{ kube_config_dir }}/certs"
	kube_token_dir: "{{ kube_config_dir }}/tokens"
	kube_addons_dir: "{{ kube_config_dir }}/addons"
	kube_manifest_dir: "{{ kube_config_dir }}/manifests"

	kube_cert_group: kube

	cluster_name: 'cluster.lan'
	dns_domain: "{{ cluster_name }}"
	dns_server: "{{ kube_service_addresses|ipaddr('net')|ipaddr(10)|ipaddr('address') }}"
	cluster_hostname: "{{ master_cluster_hostname | default('') }}"

	etcd_client_port: 2379

	etcd_ca_file: "/etc/etcd/certs/ca.crt"
	etcd_client_cert_file: "/etc/etcd/certs/client.crt"
	etcd_client_key_file: "/etc/etcd/certs/client.key"
	apiserver_etcd_certs_dir: "{{ kube_cert_dir }}/etcd"
	apiserver_etcd_ca_file: "{{ apiserver_etcd_certs_dir }}/ca.crt"
	apiserver_etcd_cert_file: "{{ apiserver_etcd_certs_dir }}/client.crt"
	apiserver_etcd_key_file: "{{ apiserver_etcd_certs_dir }}/client.key"

	kube_apiserver_options:
	  - "--tls-cert-file={{ kube_cert_dir }}/server.crt"
	  - "--tls-private-key-file={{ kube_cert_dir }}/server.key"
	  - "--tls-ca-file={{ kube_cert_dir }}/ca.crt"
	  - "--client-ca-file={{ kube_cert_dir }}/ca.crt"
	  - "--kubelet-certificate-authority={{ kube_cert_dir }}/ca.crt"
	  - "--kubelet-client-certificate={{ kube_cert_dir }}/apiserver-kubelet-client.crt"
	  - "--kubelet-client-key={{ kube_cert_dir }}/apiserver-kubelet-client.key"
	  - "--token-auth-file={{ kube_token_dir }}/known_tokens.csv"
	  - "--service-account-key-file={{ kube_cert_dir }}/server.crt"
	  - "--bind-address={{ kube_apiserver_bind_address }}"
	  - "--insecure-port=0"
	  - "--apiserver-count={{ groups[k8s_hostgroup]|length }}"
	  - "--basic-auth-file={{ kube_cert_dir }}/basic.cnf"
	  - "--anonymous-auth=false"
	  - "--allow-privileged=true"

	kube_controller_manager_options:
	  - "--kubeconfig={{ kube_config_dir }}/controller-manager.kubeconfig"
	  - "--service-account-private-key-file={{ kube_cert_dir }}/server.key"
	  - "--root-ca-file={{ kube_cert_dir }}/ca.crt"

	kube_scheduler_options:
	  - "--kubeconfig={{ kube_config_dir }}/scheduler.kubeconfig"

	kube_apiserver_additional_options: []
	kube_controller_manager_additional_options: []
	kube_scheduler_additional_options: []


Example Playbook
----------------

    - hosts: k8s_master
      roles:
         - etcd
		 - flannel
		 - docker
		 - k8s-master

Author Information
------------------

al.kashtan.ex@gmail.com