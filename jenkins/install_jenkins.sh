#!/bin/bash

set -euxo pipefail

apt-get update

apt-get install -y \
  fontconfig \
  openjdk-21-jre \
  curl \
  docker.io \
  git \
  python3 \
  python3-venv \
  python3-pip

install -m 0755 -d /etc/apt/keyrings

curl -fsSL \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
  -o /etc/apt/keyrings/jenkins-keyring.asc

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

apt-get update
apt-get install -y jenkins

usermod -aG docker jenkins

systemctl enable docker
systemctl enable jenkins
systemctl start docker
systemctl start jenkins