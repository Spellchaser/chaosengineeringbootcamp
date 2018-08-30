#!/bin/bash
# run this on all three hosts as root
# `curl https://github.com/tammybutow/chaosengineeringbootcamp/blob/master/setup.sh`
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

curl -o weave.yaml https://cloud.weave.works/k8s/v1.8/net.yaml && kubectl apply -f weave.yaml && rm weave.yaml
git clone https://github.com/microservices-demo/microservices-demo.git
cd microservices-demo/deploy/kubernetes/
kubectl create namespace sock-shop
kubectl apply -f complete-demo.yaml
kubectl get pods --namespace sock-shop -w
