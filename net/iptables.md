iptables -L -nv --line-number
iptables -L -t filter
iptables -L -t filter -nv --line-number
iptables -L INPUT
iptables -L -n 
tcpdump
wireshark

iptables [-t 表名] 选项 [链名] [条件] [-j 控制类型] 参数

-P 设置默认策略:iptables -P INPUT (DROP|ACCEPT)
-F 清空规则链
-L 查看规则链
-A 在规则链的末尾加入新规则
-I num 在规则链的头部加入新规则
-D num 删除某一条规则
-s 匹配来源地址IP/MASK，加叹号"!"表示除这个IP外。
-d 匹配目标地址
-i 网卡名称 匹配从这块网卡流入的数据
-o 网卡名称 匹配从这块网卡流出的数据
-p 匹配协议,如tcp,udp,icmp
--dport num 匹配目标端口号
--sport num 匹配来源端口号

filter：过滤，防火墙
nat：网络地址转换
mangle：拆解报文，作出修改，封装报文, 重构 
raw：关闭nat表上启用的连接追踪机制

#1、删除现有规则
iptables -F 
iptables --flush

#2. 设置默认链策略 从accept到DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

#3、阻止一个特定的IP地址

BLOCK_THIS_IP="192.168.1.108"
iptables -A INPUT -s "$BLOCK_THIS_IP" -j DROP

-s 表示匹配来源地址IP/MASK，加叹号"!"表示除这个IP外。
-j 
-j TARFET：jump至指定的TARGET 
ACCEPT：接受 
DROP：丢弃 
REJECT：拒绝 
RETURN：返回调用链 
REDIRECT：端口重定向 
LOG：记录日志 
MARK：做防火墙标记 
DNAT：目标地址转换 
SNAT：源地址转换 
MASQUEPADE：地址伪装 

也可以使用下面规则

iptables -A INPUT -i eth0 -s "$BLOCK_THIS_IP" -j DROP           //规则禁止这个IP地址对我们服务器eth0网卡的所有连接
iptables -A INPUT -i eth0 -p tcp -s "$BLOCK_THIS_IP" -j DROP   //规则只禁止这个IP地址对我们服务器eth0网卡的tcp协议的连接

-p 匹配协议,如tcp,udp,icmp

#4.允许所有传入SSH

-i 网卡名称 匹配从这块网卡流入的数据
-o 网卡名称 匹配从这块网卡流出的数据

--dport num 匹配目标端口号
--sport num 匹配来源端口号

--match             -m match               　　  extended match (may load extension)

iptables -A INPUT  -i eth0 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

#5.只能从一个特定的网络允许传入的SSH
下面的规则只允许从网络192.168.100.X传入SSH连接。
iptables -A INPUT  -i eth0 -p tcp -s 192.168.100.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

#6.允许传入的HTTP和HTTPS
以下规则允许所有传入的网络流量。即HTTP流量的端口80。
iptables -A INPUT  -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

INVALID 表示该封包的联机编号（Session ID）无法辨识或编号不正确。
ESTABLISHED 表示该封包属于某个已经建立的联机。
NEW 表示该封包想要起始一个联机（重设联机或将联机重导向）。
RELATED 表示该封包是属于某个已经建立的联机，所建立的新联机。例如：FTP-DATA 联机必定是源自某个 FTP 联机。

#7.相结合多个规则使用多端口

当你不是写为每个端口单独的规则，而是从外面的世界多个端口传入的连接，可以在一起使用多端口扩展。

下面的示例允许所有传入SSH，HTTP和HTTPS流量。
iptables -A INPUT  -i eth0 -p tcp -m multiport --dports 22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp -m multiport --sports 22,80,443 -m state --state ESTABLISHED -j ACCEPT

#8.允许OUTPUT SSH

以下规则允许传出ssh连接。也就是说当你从内ssh到外部服务器。
iptables -A OUTPUT -o eth0 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT  //允许双方新建立的OUTPUT链通信
iptables -A INPUT  -i eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT      //只允许双方已经建立的INPUT链通信 

#9.允许拨出SSH到特定网络
下面的规则只允许特定的网络传出的ssh连接。即你的SSH只有从内部网络192.168.100.0/24。

iptables -A OUTPUT -o eth0 -p tcp -d 192.168.100.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -i eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT


#10.允许拨出HTTPS

以下规则允许传出安全的Web流量。当你想允许互联网流量的用户，这是很有帮助。在服务器上，当你想使用wget从外部下载一些文件，这些规则也有帮助。

<!-- 从内下载？ -->
iptables -A OUTPUT -o eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -i eth0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

注：对于传出HTTP Web流量，增加两个额外的规则就像上面，并改变443 80。

#11.负载均衡传入的Web流量
This uses the iptables nth extension. The following example load balances the HTTPS traffic to three different ip-address. 
For every 3th packet, it is load balanced to the appropriate server (using the counter 0).
iptables -A PREROUTING -i eth0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 0 -j DNAT --to-destination 192.168.1.101:443
iptables -A PREROUTING -i eth0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 1 -j DNAT --to-destination 192.168.1.102:443
iptables -A PREROUTING -i eth0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 2 -j DNAT --to-destination 192.168.1.103:443

nth --counter 0 --every 3 --packet 0 ？

#12.允许从外部到内部Ping

iptables -A INPUT  -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

--icmp-type echo-request  》 ping

--icmp-type echo-reply   》 pong

#13.允许从内部到外部ping

以下规则允许您从内部ping到任何外部服务器。

iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT  -p icmp --icmp-type echo-reply -j ACCEPT

#14.允许环回访问
环回接口(loopback interface)的新认识
https://www.cnblogs.com/hustcat/p/3920940.html

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

<!-- 不是很明白换回接口 -->

#15.允许内部网络到外部网络

这个例子eth1 连接外部网络，eth0连接内部网络
在防火墙服务器上，一个以太网卡连接到外部网络，另一个以太网卡连接到内部服务器，请使用以下规则允许内部网络与外部网络通信
//在此示例中，eth1连接到外部网络（互联网），eth0连接到内部网络（例如：192.168.1.x）。
iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

#16.允许出站DNS

以下规则允许传出DNS连接。

iptables -A OUTPUT -p udp -o eth0 --dport 53 -j ACCEPT
iptables -A INPUT -p udp -i eth0 --sport 53 -j ACCEPT

#17.允许NIS连接

#18。允许Rsync来自特定网络

#19.仅允许来自特定网络的MySQL连接

iptables -A INPUT  -i eth0 -p tcp -s 192.168.100.0/24 --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 3306 -m state --state ESTABLISHED -j ACCEPT

20.允许Sendmail或Postfix流量
#21.允许IMAP和IMAPS
#22.允许POP3和POP3S
#23.防止DoS攻击

iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

在上面的例子中：
　　-m limit：这使用限制iptables扩展
　　-limit 25 /分钟：每分钟最多只能连接25个请求包。根据您的具体要求更改此值
　　-limit-burst 100：此值指示仅在连接的总数达到limit之后才实施限制/分钟

注意“-m limit”只匹配数据包而不是连接，所以上方例子中你将匹配25包每分钟。

如果是想限制每分钟下connect次数呢。限制连接数的解决方案是使用connlimit匹配。

iptables -A INPUT -p tcp –syn –dport 80 -m connlimit –connlimit-above 15 –connlimit-mask 32 -j REJECT –reject-with tcp-reset

它将拒绝来自一个源IP的15以上的连接 - 一个很好的规则来保护Web服务器。

此外，当与“hashlimit” 结合后在保护免受DDoS攻击时效果更好。

使用“limit”匹配，您可以限制每个时间间隔的数据包的全局速率，但是使用“hashlimit”，您可以限制每个IP，每个组合IP +端口等。

所以一个Web服务器的例子将是这样：
iptables -A INPUT -p tcp –dport 80 -m hashlimit –hashlimit 45/sec –hashlimit-burst 60 
–hashlimit-mode srcip–hashlimit-name DDOS 
–hashlimit-htable-size 32768 
–hashlimit-htable-max 32768 
–hashlimit-htable-gcinterval 1000 
–hashlimit-htable-expire 100000 
-j ACCEPT

#24. 端口转发
例：将来自422端口的流量全部转到22端口。

这意味着我们既能通过422端口又能通过22端口进行ssh连接。启用DNAT转发。

iptables -t nat -A PREROUTING -p tcp -d 192.168.102.37 --dport 422 -j DNAT --to 192.168.102.37:22

除此之外，还需要允许连接到422端口的请求
iptables -A INPUT -i eth0 -p tcp --dport 422 -m state --state NEW,ESTABLISHED -j ACCEPTiptables -A OUTPUT 
                  -o eth0 -p tcp --sport 422 -m state --state ESTABLISHED -j ACCEPT

#25. 记录丢弃的数据表

iptables -N LOGGING   //1.新建名为LOGGING的链
iptables -A INPUT -j LOGGING  //2.将所有来自INPUT链中的数据包跳转到LOGGING链中
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables Packet Dropped: " --log-level 7  
//3.为这些包自定义个前缀，命名为”IPTables Packet Dropped”
iptables -A LOGGING -j DROP   //4.丢弃这些数据包 


NAT有三个作用：

◇ 地址转换。让内网(私有地址)可以共用一个或几个公网地址连接Internet。这是从内向外的，需要在网关式防火墙的POSTROUTING处修改源地址，这是SNAT功能。

◇ 保护内网服务器。内网主机连接Internet使用的是公网地址，对外界而言是看不到内网服务器地址的，所以外界想要访问内部主机只能经过防火墙主机的公网地址，然后将目标地址转换为内网服务器地址，这起到了保护内网服务器的作用。转换目标地址需要在网关式防火墙的PREROUTING链处修改，这是DNAT功能。

◇ 不仅可以修改目标地址，还可以使用端口映射功能。DNAT是修改目标地址，端口映射是修改目标端口。如将web服务器的8080端口映射为防火墙的80端口。

外网主机和内网主机通信有两种情况的数据包：一种情况是建立NEW状态的新请求连接数据包，一种是回应的数据包。无论哪种情况，在NEW状态数据包经过地址转换之后会在防火墙内存中维护一张NAT表，保存未完成连接的地址转换记录，这样在回应数据包到达防火墙时可以根据这些记录路由给正确的主机。

也就是说，SNAT主要应付的是内部主机连接到Internet的源地址转换，转换的位置是POSTROUTING链；DNAT主要应付的是外部主机连接内部服务器防止内部服务器被攻击的目标地址转换，转换位置在PREROUTING；端口映射可以在多个地方转换。