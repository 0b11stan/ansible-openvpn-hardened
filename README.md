# Ansible for hardened OpenVPN

## Usage

Dans un premier temps, copiez le fichier d'inventaire pour modifier les valeurs souhaités.
```bash
cp inventory.ini.dist inventory.ini
vim inventory.ini
```

Pour jouer votre playbook:
```bash
make apply
```

## Devellopement

For devellopement purpose, you can use docker to test the playbook locally.
* `make build`: build a docker image with ssh and systemd.
* `make start`: start a docker instance mocking an openvpn server.
* `make dev`: run ansible playbook against the docker instance.
* `make clean`: stop and destroy the docker instance.

See `Makefile` for more details.
