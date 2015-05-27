#!/usr/bin/env bash

apt-get -y update
apt-get install -y git mercurial subversion wget curl make vim tree python perl nodejs node-growl gcc g++ ssh openssh-client gnupg gnupg-agent linux-image-generic-lts-trusty

wget -qO- https://get.docker.com/ | sh

useradd -U -G docker,sudo -m -p $(echo "==>PLAINTEXT_PASSWORD<===" | openssl passwd -1 -stdin) -s /bin/bash ==>DEVBOX_USERNAME<=== 
mkdir -p /home/==>DEVBOX_USERNAME<===/go /home/==>DEVBOX_USERNAME<===/bin /home/==>DEVBOX_USERNAME<===/projects /home/==>DEVBOX_USERNAME<===/.ssh

echo "==>MY_SSH_PUBLIC_KEY<===" >> /home/==>DEVBOX_USERNAME<===/.ssh/authorized_keys

curl -L https://bit.ly/cig-install | bash
echo "---" > /home/==>DEVBOX_USERNAME<===/.cig.yaml
echo "work: /home/==>DEVBOX_USERNAME<===/projects" >> /home/==>DEVBOX_USERNAME<===/.cig.yaml

chown -R ==>DEVBOX_USERNAME<===:==>DEVBOX_USERNAME<=== /home/==>DEVBOX_USERNAME<===

sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i -e '$aPasswordAuthentication no' /etc/ssh/sshd_config
sed -i -e '$aAllowUsers ==>DEVBOX_USERNAME<===' /etc/ssh/sshd_config
restart ssh
