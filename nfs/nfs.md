关于sc,pv,pvc。


#安装nfs
sudo apt install nfs-kernel-server

/nfs/ *(async,insecure,no_root_squash,no_subtree_check,rw)

kubectl exec -it nfs-busybox-774d7cc7b9-5pkwz /bin/sh

df -h

ll /nfs

