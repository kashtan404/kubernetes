Role Name
=========

docker

Role Variables
--------------

	docker_version: "1.12.6"

	log_driver: gelf
	gelf_host: "10.47.12.101"

Example Playbook
----------------

    - hosts: docker
      roles:
         - docker

Author Information
------------------

al.kashtan.ex@gmail.com