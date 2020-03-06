cat vars
./easyrsa init-pki
./easyrsa build-ca
| ca key passphrase : P@ssw0rd
| common name : Epsi VPN

./easyrsa build-server-full server
| pem pass phrase : P@ssw0rd

./easyrsa build-client-full francois
| pem pass phrase : montagne

./easyrsa gen-dh
| ==> /usr/share/easy-rsa/3/pki/dh.pem


