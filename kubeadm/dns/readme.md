kubectl run -it --rm --image=infoblox/dnstools dns-client

内网链接外网出问题
nslookup kubernetes.default

kubectl scale deployment coredns --replicas=2 -n kube-system

#问题
https://www.jianshu.com/p/590a8dfdf9a9

#解决办法1
https://blog.csdn.net/evanxuhe/article/details/90229597
#解决办法2
https://blog.csdn.net/zhangxiangui40542/article/details/85016266

https://blog.csdn.net/dkfajsldfsdfsd/article/details/81218480

https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/

sudo rm /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

sudo /etc/init.d/networking restart

dashboard.shitangdama.cn