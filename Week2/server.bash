#!/bin/bash

# Storyline: Script to create a wireguard server


# Create a private key
private="$(wg genkey)"

# Create a public key
public="$(echo ${private} | wg pubkey)"

# Set the addresses
address="10.254.132.0/24,172.16.28.0/24"

# Set Server Address
ServerAddress="10.254.132.1/24,172.16.28.1/24"

# Set the Listen Port
lport="4282"

# Create the format for the client configuration options
peerinfo="# ${address} 162.243.2.92:4282 ${public} 8.8.8.8,1.1.1.1 1280 120 0.0.0.0/0"


echo "${peerinfo}
[Interface]
Address = ${ServerAddress}
#PostUp = /etc/wireguard/wg-up.bash
#PostDown = /etc/wireguard/wg-down.bash
ListenPort = ${lport}
PrivateKey = ${private}
" > wg0.conf
