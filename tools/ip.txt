##############################################################################
# IP CHEATSHEET (中文速查表)  -  by skywind (created on 2024/11/12)
# Version: 3, Last Modified: 2024/11/23 20:47:35
# https://github.com/skywind3000/awesome-cheatsheets
##############################################################################


##############################################################################
# 辅助参数
##############################################################################

ip -n s1 ip addr                              # 在网络命名空间中执行 ip addr
ip -c link                                    # 彩色显示接口
ip -c addr                                    # 彩色显示地址
ip -c route                                   # 彩色显示路由
ip -brief link                                # 简洁显示接口
ip -brief addr                                # 简洁显示地址
ip -brief -c link                             # 彩色简洁显示接口


##############################################################################
# ip addr
##############################################################################

ip addr                                       # 查看地址
ip addr add 192.168.1.1/24 dev eth0           # 给指定设备添加地址
ip addr del 192.168.1.1/24 dev eth0           # 删除指定设备的地址
ip addr flush dev eth0                        # 删除指定设备的所有地址


##############################################################################
# ip link
##############################################################################

ip link                                       # 显示所有网络接口
ip link show dev eth0                         # 显示指定设备的信息
ip link set eth0 up                           # 把 eth0 接口设备开启
ip link set eth0 down                         # 把 eth0 接口设备关闭
ip link set eth0 mtu 1450                     # 设置设备的 MTU
ip link add br0 type bridge                   # 添加一个网桥设备
ip link del br0                               # 删除一个网桥设备
ip link set eth0 master br0                   # 把 eth0 添加到网桥 br0
ip link set eth0 nomaster                     # 从网桥中删除 eth0
ip link add veth0 type veth peer name veth1   # 添加虚拟以太网设备
ip link set veth0 netns s1                    # 把 veth0 移动到网络命名空间
ip link set veth1 netns s2                    # 把 veth1 移动到网络命名空间
ip link set veth0 netns 1                     # 把设备移动到全局网络命名空间


##############################################################################
# ip route
##############################################################################

ip route                                      # 显示主路由表
ip route show table [local|main|default|num]  # 显示路由表
ip route show table main                      # 显示主路由表
ip route show table 520                       # 显示编号为 520 的路由表
ip route get 8.8.8.8                          # 查询一个地址经过的路由
ip route get 8.8.8.8 mark 666                 # 查询经过的路由（带标记）
ip route add default via 10.8.1.1 dev eth0    # 添加默认路由
ip route add 10.8.1.0/24 via 10.8.1.1         # 添加静态路由
ip route add 10.8.1.0/24 dev eth0             # 添加直连路由
ip route add 10.8.1.1/24 dev eth0 metric 10   # 添加带有 metric 的直连路由
ip route add 10.8.1.0/24 dev eth0 table 520   # 添加路由到编号 520 的路由表
ip route add table 520 10.8.1.0/24 dev eth0   # 另一种写法，突出表名
ip route delete 10.8.1.0/24 via 10.8.1.1      # 删除静态路由
ip route replace 10.8.1.0/24 dev eth0         # 替换路由
ip route flush cache                          # 路由表立即生效
ip route flush table 520                      # 清空编号为 520 的路由表

# 显示当前定义了哪些路由表
ip route show table all | grep -Eo 'table [^ ]+ ' | sort | uniq


##############################################################################
# ip rule
##############################################################################

ip rule                                       # 显示路由规则
ip rule add table 520                         # 所有包走一下 520 路由表
ip rule add from 0/0 lookup 520               # 所有包走一下 520 路由表
ip rule add from 0/0 table 520                # 同上
ip rule add from 0/0 blackhole                # 所有包丢弃
ip rule add from 0/0 prohibit                 # 所有包拒绝，通信被管理员禁止
ip rule add from 0/0 unreachable              # 返回 network unreachable
ip rule del table 520                         # 删除所有包走 520 路由表的规则
ip rule add from 10.8.1.0/24 table 520        # 来自特定网络的包走 520 路由表
ip rule add to 10.8.2.0/24 table 521          # 发往某网络的包走 521 路由表
ip rule add fwmark 588 table 520              # 标记为 588 的包走 520 路由表
ip rule add not fwmark 588 table 51820        # 没有标记为 588 的包走该路由表
ip rule add from 8.8.3.2/32 tos 10 table ２   # 来自特定 IP 且 TOS 为 10 的包
ip rule add prio 100 fwmark 1 lookup 100      # 优先级 100 的规则


##############################################################################
# ip netns
##############################################################################

ip netns                                      # 显示网络命名空间
ip netns add s1                               # 创建一个网络命名空间
ip netns del s1                               # 删除一个网络命名空间
ip netns attach NAME PID                      # 改变进程网络命名空间
ip netns exec s1 command                      # 在网络命名空间中执行命令
ip netns identify                             # 查看当前进程的网络命名空间
ip netns identify PID                         # 查看指定进程的网络命名空间
ip netns pids NAME                            # 查看网络命名空间中的进程
ip -n s1 addr add 192.168.64.1/24 dev veth0   # 在网络命名空间中添加地址


##############################################################################
# Reference
##############################################################################

https://cheatography.com/tme520/cheat-sheets/iproute2/
https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf



# vim: set ts=4 sw=4 tw=0 et ft=bash :

