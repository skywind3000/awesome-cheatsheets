# H3C (Comware) 常用配置速查

适用 Comware V5/V7。V7 为准，V5 差异标注。

## 基础

```bash
system-view                          # 进系统视图
sysname CORE-SW1                     # 设备名
display version                      # 版本
display current-configuration       # 当前配置
display saved-configuration         # 启动配置
save                                 # 保存（V7 会提示确认）
undo info-center enable              # 关日志（排障时）
```

## VLAN

```bash
vlan 100                             # 建 VLAN
name OFFICE
port GigabitEthernet1/0/1 to GigabitEthernet1/0/10   # 批量 access
quit

interface Vlan-interface100          # SVI
ip address 192.168.100.1 24

interface GigabitEthernet1/0/24      # trunk 口
port link-type trunk
port trunk permit vlan 100 200
port trunk pvid vlan 1
```

## 链路聚合

```bash
interface Bridge-Aggregation1        # V5 是 Bridge-Aggregation
link-aggregation mode dynamic        # LACP
quit
interface range GigabitEthernet1/0/1 to GigabitEthernet1/0/2
port link-aggregation group 1
```

## STP

```bash
stp enable
stp mode mstp
stp region-configuration
region-name RG1
instance 1 vlan 100
instance 2 vlan 200
active region-configuration
quit
stp root primary        # 根桥（全局）
stp priority 0          # 或手调优先级
```

## SSH 管理

```bash
public-key local create rsa          # 生成密钥
ssh server enable
user-interface vty 0 4
authentication-mode scheme
protocol inbound ssh
quit
local-user admin
password simple <PWD>
service-type ssh
authorization-attribute user-role network-admin
```

## 端口安全（防私接）

```bash
interface GigabitEthernet1/0/1
port-security enable
port-security max-mac-count 4
port-security port-mode autolearn
```

## 常用排障

```bash
display interface brief              # 端口 UP/流量速览
display link-aggregation verbose     # 聚合状态
display stp brief                    # STP 角色
display mac-address                  # MAC 表
display arp                          # ARP 表
display ip routing-table             # 路由表
ping -a 192.168.100.1 8.8.8.8        # 指定源 ping
```

> 巡检自动化可用 [netcfg-vault](https://github.com/BG8CFB/netcfg-vault) 批量导出全网配置做基线比对。

---

> 完整版（含华为/思科对照、每日巡检清单、巡检报告模板）：https://github.com/BG8CFB/netops-cheatsheets
