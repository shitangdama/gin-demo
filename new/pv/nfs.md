关于sc,pv,pvc。


#安装nfs
sudo apt install nfs-kernel-server

/etc/exports

/node *(async,insecure,no_root_squash,no_subtree_check,rw)

sudo /etc/init.d/nfs-kernel-server restart

<!-- 导出 -->
showmount -e 192.168.123.142

kubectl exec -it nfs-busybox-774d7cc7b9-5pkwz /bin/sh

df -h

ll /nfs

sudo /etc/init.d/networking restart
sudo /etc/init.d/nfs-kernel-server restart

mount -t nfs 192.168.123.142:/home/shitangdama/data /mnt

umount /mnt

kubectl patch pv nfs -p '{"metadata":{"finalizers":null}}'

kubectl patch pvc drone -p '{"metadata":{"finalizers":null}}'