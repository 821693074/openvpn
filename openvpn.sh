#! /bin/bash

if [ "$USER" != "root" ]
then
    echo "当前非root账号，请使用管理员账号"
    return
fi

if [ "$#" != "1" || "$1" == "*" || "$1" == "." || "$1" == '/' ]
then
    echo '用户名不能为空！'
    return
fi

echo $1

cd /etc/openvpn/easy-rsa

source ./vars

./build-key-pass clients/$1

mkdir -p /home/chenzhiming/openvpn-keys/$1

cp keys/ca.crt keys/clients/$1.crt keys/clients/$1.key /home/chenzhiming/openvpn-keys/$1/

cp keys/clients/client-config.ovpn /home/chenzhiming/openvpn-keys/$1/$1@tengyue.ovpn

sed -i 's/\[todo\]/$1/g' /home/chenzhiming/openvpn-keys/$1/$1@tengyue.ovpn

cd /home/chenzhiming/openvpn-keys/$1

tar czvf $1.tar.gz ./*

chown -R chenzhiming:chenzhiming ./

echo $1'VPN开通成功！！'