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

