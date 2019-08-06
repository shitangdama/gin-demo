#关于openssl和cfssl

#关于pem crt key

key是私钥
crt是公钥 证书

证书(Certificate) .cer .crt 
私钥(Private Key).key 

至于pem和der，是编码方式，以上三类均可以使用这两种编码方式，因此.pem和.der(少见)不一定是以上三种(Cert,Key,CSR)中的某一种

PEM - Privacy Enhanced Mail,打开看文本格式,以”—–BEGIN…”开头, “—–END…”结尾,内容是BASE64编码. 
查看PEM格式证书的信息:openssl x509 -in certificate.pem -text -noout 
Apache和*NIX服务器偏向于使用这种编码格式.

DER - Distinguished Encoding Rules,打开看是二进制格式,不可读. 
查看DER格式证书的信息:openssl x509 -in certificate.der -inform der -text -noout 
Java和Windows服务器偏向于使用这种编码格式.

默认的配置文件
cfssl print-defaults config > ca-config.json

证书签名请求文件
cfssl print-defaults csr > ca-csr.json

这里略有不一样的地方

{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ],
        "expiry": "87600h"
      }
    }
  }
}
字段说明
ca-config.json：可以定义多个 profiles，分别指定不同的过期时间、使用场景等参数；后续在签名证书时使用某个 profile；
signing：表示该证书可用于签名其它证书；生成的 ca.pem 证书中 CA=TRUE；
server auth：表示client可以用该 CA 对server提供的证书进行验证；
client auth：表示server可以用该CA对client提供的证书进行验证；

{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "ShangHai",
      "L": "ShangHai",
      "O": "k8s",
      "OU": "System"
    }
  ],
    "ca": {
       "expiry": "87600h"
    }
}

"CN"：Common Name，kube-apiserver 从证书中提取该字段作为请求的用户名 (User Name)；浏览器使用该字段验证网站是否合法；
"O"：Organization，kube-apiserver 从证书中提取该字段作为请求用户所属的组 (Group)；

公用名称 (Common Name)	简称：CN 字段，对于 SSL 证书，一般为网站域名；而对于代码签名证书则为申请单位名称；而对于客户端证书则为证书申请者的姓名；
组织名称,公司名称(Organization Name)	简称：O 字段，对于 SSL 证书，一般为网站域名；而对于代码签名证书则为申请单位名称；而对于客户端单位证书则为证书申请者所在单位名称；
组织单位名称，公司部门(Organization Unit Name) 简称：OU字段

证书申请单位所在地
所在城市 (Locality)	简称：L 字段
所在省份 (State/Provice) 简称：S 字段，State：州，省
所在国家 (Country)	简称：C 字段，只能是国家字母缩写，如中国：CN