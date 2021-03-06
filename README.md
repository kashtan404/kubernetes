Playbook Name
=========

kubernetes-cluster

Install kubernetes cluster with ssl.
Lookout default vars each role before use it.

Example Playbook
----------------

    - name: Install master
      hosts: k8s_master
      become: true
      roles:
        - { role: etcd, k8s_hostgroup: 'k8s_master_stage' }
        - { role: flannel, k8s_hostgroup: 'k8s_master_stage' }
        - docker
        - { role: k8s-master, k8s_hostgroup: 'k8s_master_stage', k8s_hostgroup_node: 'k8s_node_stage' }

    - name: Install minions
      hosts: k8s_minion
      become: true
      roles:
        - { role: flannel, k8s_hostgroup: 'k8s_master_stage' }
        - docker
        - { role: k8s-node, k8s_hostgroup: 'k8s_master_stage' }


Author Information
------------------

al.kashtan.ex@gmail.com