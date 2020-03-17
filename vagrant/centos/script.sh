sudo yum update -y
sudo yum install wget git qemu-kvm -y
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2 -y
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo yum install ./containerd.io-1.2.6-3.3.el7.x86_64.rpm -y
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli -y
echo "export DOCKER_CLI_EXPERIMENTAL=enabled" | sudo tee -a /home/vagrant/.bashrc
source /home/vagrant/.bashrc
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl start docker

# +++ to resolve error
# failed to solve: rpc error: code = Unknown desc = failed to solve with frontend dockerfile.v0: failed to build LLB: failed to load cache key: failed to do request: Head https://registry-1.docker.io/v2/library/node/manifests/12.16.1: dial tcp: lookup registry-1.docker.io on 10.0.2.3:53: read udp 172.17.0.2:47158->10.0.2.3:53: i/o timeout
echo '{"dns":["8.8.8.8","8.8.4.4"]}' | sudo tee -a /etc/docker/daemon.json
# ---

docker run --restart always -d --privileged multiarch/qemu-user-static --reset -p yes
sudo systemctl restart docker




