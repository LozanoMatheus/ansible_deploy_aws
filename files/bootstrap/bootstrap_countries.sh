#!/bin/bash

set -xe

function install_docker() {
  amazon-linux-extras install docker
  systemctl enable docker
  systemctl start docker
}

yum -y update
yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install git psutils iproute curl telnet nc jq

install_docker

docker run -dit -p 8000:8080 lozanomatheus/countries-assembly:1.0.1

curl -v http://localhost:8000/health/ready &
