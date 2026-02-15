init 3
subscription-manager register
subscription-manager status 
yum check-update 
yum -y update
ps -ef
yum check-update 
yum -y update
yum check-update 
yum kernel list
yum list kernel
uname -a
reboot
ipconfig
ifconfig
hostname
lsblk
ls
vi extend_root_by_60g.sh
cat extend_root_by_60g.sh 
chmod +x extend_root_by_60g.sh 
./extend_root_by_60g.sh 
lsblk
df -h
pvg
pv
vgs
lvg
pvdisplay
vgdisplay
lsblk
df -h
xfs_growfs
xfs_growfs /
lsblk
df -h
xfs_growfs /dev/mapper/rhel-root
lsblk
lvs
pvs
lvs
pvs
vgs
lvdisplay
lvextend -L +100G /dev/rhel/root
xfs_grow /dev/rhel/root
xfs_growfs /dev/rhel/root
vgs
vgdisplay
vgs
lsblk
vgdisplay
pvdisplay
lvextend -L +100G /dev/nvme0n2/rhel
lvdisplay
vgextent rhel /dev/nvme0n1p2
vgextend rhel /dev/nvme0n1p2
lvextend -L +100G /dev/rhel/root
lvextend -r -L +60G /dev/rhel/root
lvextend -r -l +100%FREE /dev/rhel/root
lsblk
df -h
xfs_growfs
xfs_growfs /dev/rhel/root
cat /etc/fstab
lsblk
free -h
df -h
ls
rm -f extend_root_by_60g.sh 
ifconfig
10.0.0.114stephenntiri
hostname
ifconfig
hostname
sudo systemctl stop rke2-agent
sudo systemctl disable rke2-agent
sudo /usr/local/bin/rke2-killall.sh 2>/dev/null || true
sudo rm -f /etc/cni/net.d/*
sudo rm -rf /var/lib/cni /var/lib/kubelet/*
sudo ip link del cni0 2>/dev/null || true
sudo ip link del flannel.1 2>/dev/null || true
reboot
sudo systemctl stop rke2-agent
sudo systemctl disable rke2-agent
sudo /usr/local/bin/rke2-killall.sh 2>/dev/null || true
sudo rm -f /etc/cni/net.d/*
sudo rm -rf /var/lib/cni /var/lib/kubelet/*
sudo ip link del cni0 2>/dev/null || true
sudo ip link del flannel.1 2>/dev/null || true
ls -l /etc/yum.repos.d/kubernetes.repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=0
EOF

sudo dnf install -y kubeadm kubelet kubectl containerd
sudo systemctl enable --now kubelet containerd
systemctl status kubelet
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
# Remove or override any excludes; this is essential
#exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
sudo dnf install -y kubelet kubectl --disableexcludes=kubernetes --disableplugin=priorities
systemctl enable --now kubelet containerd
dnf install -y kubeadm kubelet kubectl containerd
sudo dnf install -y containerd kubeadm --disableexcludes=kubernetes --disableplugin=priorities
sudo dnf -y install yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y containerd.io
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
# Switch to systemd cgroups (important for kubelet)
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl enable --now containerd
containerd --version
systemctl status containerd
cat /etc/systemd/system/kubelet.service.d
systemctl status kubelet.service 
cat /etc/containerd/config.toml
cat /etc/containerd/config.toml| grep SystemdCgroup 
cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl start kubelet.service 
systemctl status kubelet.service 
sudo mkdir -p /etc/systemd/system/kubelet.service.d
cat <<EOF | sudo tee /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
[Service]
Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=systemd"
EOF

systemctl start kubelet.service 
sudo systemctl daemon-reexec
sudo systemctl restart kubelet
sudo systemctl enable kubelet
systemctl status kubelet.service 
sudo journalctl -u kubelet -n 20 | grep cgroup
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/' /etc/fstab
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
netstat -ntpl
systemctl stop kubelet.service 
netstat -ntpl
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
journalctl -xeu kubelet
journalctl -xeu kubelet -l
systemctl status kubelet.service 
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
systemctl restart kubelet.service 
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
systemctl stop kubelet.service 
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
rm -f /etc/kubernetes/pki/ca.crt
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
systemctl status kubelet.service 
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
rm -f /etc/kubernetes/pki/ca.crt
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77 --ignore-preflight-errors=...
kubeadm join 10.0.0.247:6443 --token efh9zz.cwsg3x1yhp8ostug   --discovery-token-ca-cert-hash sha256:2a3566c0d33a6626a7a5ba0be8eab4b9966ea0efa0fc9d8b55b518ee57b4bc77 --ignore-preflight-errors=... --v=5
# Stop kubelet (kubeadm will start it itself during join)
sudo systemctl stop kubelet
# If you previously ran RKE2 on this node, stop/disable it completely
sudo systemctl stop rke2-agent rke2-server 2>/dev/null || true
sudo systemctl disable rke2-agent rke2-server 2>/dev/null || true
sudo /usr/local/bin/rke2-killall.sh 2>/dev/null || true
pgrep -a kubelet
sudo pkill kubelet || true
# Confirm port is free
sudo ss -ltnp | grep 10250 || echo "10250 is free"
# Only if you were switching from RKE2 or a stale kubeadm attempt
sudo rm -f /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf
sudo rm -rf /var/lib/kubelet/*
# Optional: clear CNI leftovers that can cause weirdness
sudo rm -f /etc/cni/net.d/* ; sudo rm -rf /var/lib/cni
reboot
ifconfig
dnf check-update
subscription-manager register 
subscription-manager register --force
dnf check-update
dnf -y update
reboot
