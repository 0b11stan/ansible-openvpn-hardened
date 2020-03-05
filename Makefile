SSH_USER=tristan
SSH_PASS=azerty
CTR_NAME=ovpnh
CTR_IP=$$(docker exec $(CTR_NAME) hostname -i)

ANSIBLE_CMD=ansible-playbook -i inventory.ini -kK site.yml

build:
	docker build -t $(CTR_NAME) .

start:
	docker run --privileged --name $(CTR_NAME) \
		-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
		-p 80:80 -d $(CTR_NAME)

clean:
	docker stop $(CTR_NAME) && docker rm $(CTR_NAME)

shell:
	docker exec -it $(CTR_NAME) /bin/bash

ssh:
	echo $(SSH_USER):$(SSH_PASS) | docker exec $(CTR_NAME) chpasswd
	ssh $(SSH_USER)@$(CTR_IP)

ansible-prepare:
	cp inventory.ini.dist inventory.ini
	echo $(CTR_IP) | tee -a inventory.ini

check: ansible-prepare
	$(ANSIBLE_CMD) --check --diff

apply: ansible-prepare
	$(ANSIBLE_CMD)
