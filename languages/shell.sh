# 获取进程pid
ps aux | grep -v grep | awk '{print $2}'

# 杀掉所有进程
ps aux | grep <proc name> | grep -v grep | awk '{print $2}' | xargs kill -9


# awk
# 每行按空格或TAB分割，输出文本中的1、4项
awk '{print $1,$4}' log.txt
# 使用","分割
awk -F, '{print $1,$2}'   log.txt
# 使用多个分隔符.先使用空格分割，然后对分割结果再使用","分割
awk -F '[ ,]'  '{print $1,$2,$5}'   log.txt


# Docker
# 启动容器
docker run --name=my_container -it rep:tag /bin/bash
# 端口映射
docker run --name=my_container -it -p 10022:22 -p 18080:8080 rep:tag /bin/bash

# system-uuid
dmidecode -s system-uuid

# 网络
# netstat
# 显示所有端口
netstat -a
# 显示监听端口
netstat -l
# 显示tcp监听端口
netstat -lt
# 显示udp监听端口
netstat -lu

# 防火墙
service iptables status
service iptables stop/start

firewall-cmd --state
systemctl stop firewalld.service
systemctl disable firewalld.service

# nginx
# 编译调试版本
./configure --with-debug --without-http_rewrite_module
# 在objs/Makefile中添加 -g -O0
make && make install
# nginx.conf 配置文件中添加
# daemon off;
# master_process off;

# gdb
# 设置当进程调用fork时gdb是否同时调试父子进程
set detach-on-fork on/off
# 设置当进程调用fork时是否进入子进程
set follow-fork-mode parent/child

# CentOS7修改默认内核
# 查看当前内核版本
uname -r
# 查看当前默认启动内核
[root@infosec ~]# grub2-editenv list
saved_entry=CentOS Linux (3.10.0-1160.76.1.el7.x86_64) 7 (Core)
# 确认系统当前已安装内核版本
cat /boot/grub2/grub.cfg | grep -v rescue | grep ^menuentry
# menuentry 'CentOS Linux 7 Rescue b25596acf71342288e5596e95af749bb (3.10.0-1160.76.1.el7.x86_64)' --class
# menuentry 'CentOS Linux (3.10.0-1160.76.1.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class
rpm -qa kernel
# kernel-3.10.0-1160.76.1.el7.x86_64
# kernel-3.10.0-957.el7.x86_64
# 设置默认启动内核
grub2-set-default 'CentOS Linux (3.10.0-693.el7.centos.toa.x86_64) 7 (Core)'
grub2-editenv list
# saved_entry=CentOS Linux (3.10.0-693.el7.centos.toa.x86_64) 7 (Core)
# menuentry 'CentOS Linux (3.10.0-957.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class


# curl 使用代理
curl -x https://10.20.62.74:7893 -U chm:chm123 https://www.google.com
curl --proxy https://10.20.62.74:7893 --proxy-user chm:chm123 https://www.google.com
# 设置代理
curl -x http://10.20.62.74:7893 -U chm:chm123 www.baidu.com > /dev/null
export proxy="http://chm:chm123@10.20.62.74:7893"
export http_proxy=$proxy
export https_proxy=$proxy
export ftp_proxy=$proxy
export no_proxy="localhost, 127.0.0.1, ::1"

# 下载proxychains
apt search proxychains4
apt install proxychains4

# 编译proxychains4
https://github.com/haad/proxychains/archive/refs/tags/proxychains-4.4.0.tar.gz
tar zvxf proxychains-4.4.0.tar.gz
cd proxychains-proxychains-4.4.0/
./configure
# 修改Makefile中的CFLAGS，把-Werror删除
make
sudo make install
cp src/proxychains.conf /etc/

