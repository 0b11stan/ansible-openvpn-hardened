SSH_USER=tristan
SSH_PASS=azerty
CTR_NAME=ovpnh
CTR_IP=$$(docker exec $(CTR_NAME) hostname -i)

ANSIBLE_CMD=ansible-playbook -i inventory.ini -kK site.yml

build:
	docker build \
		--build-arg SSH_USER=$(SSH_USER) \
		--build-arg SSH_PASS=$(SSH_PASS) \
		-t $(CTR_NAME) .

start:
	docker run --privileged --name $(CTR_NAME) \
		-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
		-p 80:80 -d $(CTR_NAME)

clean:
	docker stop $(CTR_NAME) && docker rm $(CTR_NAME)

shell:
	docker exec -it $(CTR_NAME) /bin/bash

ssh-prepare:
	sed -i "s/$(CTR_IP)//" ~/.ssh/known_hosts

ssh: ssh-prepare
	ssh $(SSH_USER)@$(CTR_IP)

ansible-prepare:
	cp inventory.ini.dist inventory.ini
	echo $(CTR_IP) | tee -a inventory.ini

dev: ssh-prepare ansible-prepare
	$(ANSIBLE_CMD)

iptables: ssh-prepare ansible-prepare
	$(ANSIBLE_CMD) -t iptables

test:
	cd ovpn && sudo openvpn --config client.ovpn

check:
	$(ANSIBLE_CMD) --check --diff

apply:
	$(ANSIBLE_CMD)
