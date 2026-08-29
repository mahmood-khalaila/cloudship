#!/bin/bash

set -euxo pipefail

apt-get update
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu