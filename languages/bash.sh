##############################################################################
# BASH CHEATSHEET (中文速查表)  -  by skywind (created on 2018/02/14)
# Version: 25, Last Modified: 2018/02/25 15:36
# https://github.com/skywind3000/awesome-cheatsheets
##############################################################################


##############################################################################
# 常用快捷键
##############################################################################

CTRL+A              # 移动到行首，同 <Home>
CTRL+B              # 向后移动，同 <Left>
CTRL+C              # 结束当前命令
CTRL+D              # 删除光标前的字符，同 <Delete> ，或者没有内容时，退出会话
CTRL+E              # 移动到行末，同 <End>
CTRL+F              # 向前移动，同 <Right>
CTRL+G              # 退出当前编辑（比如正在 CTRL+R 搜索历史时）
CTRL+H              # 删除光标左边的字符，同 <Backspace>
CTRL+K              # 删除光标位置到行末的内容
CTRL+L              # 清屏并重新显示
CTRL+N              # 移动到命令历史的下一行，同 <Down>
CTRL+O              # 类似回车，但是会显示下一行历史
CTRL+P              # 移动到命令历史的上一行，同 <Up>
CTRL+R              # 历史命令反向搜索，使用 CTRL+G 退出搜索
CTRL+S              # 历史命令正向搜索，使用 CTRL+G 退出搜索
CTRL+T              # 交换前后两个字符
CTRL+U              # 删除字符到行首
CTRL+V              # 输入字符字面量，先按 CTRL+V 再按任意键
CTRL+W              # 删除光标左边的一个单词
CTRL+X              # 列出可能的补全
CTRL+Y              # 粘贴前面 CTRL+u/k/w 删除过的内容
CTRL+Z              # 暂停前台进程返回 bash，需要时可用 fg 将其切换回前台
CTRL+_              # 撤销（undo），有的终端将 CTRL+_ 映射为 CTRL+/ 或 CTRL+7

ALT+b               # 向后（左边）移动一个单词
ALT+d               # 删除光标后（右边）一个单词
ALT+f               # 向前（右边）移动一个单词
ALT+t               # 交换字符
ALT+BACKSPACE       # 删除光标前面一个单词，类似 CTRL+W，但不影响剪贴板

CTRL+X CTRL+X       # 连续按两次 CTRL+X，光标在当前位置和行首来回跳转 
CTRL+X CTRL+E       # 用你指定的编辑器，编辑当前命令


##############################################################################
# BASH 基本操作
##############################################################################

exit                # 退出当前登陆
env                 # 显示环境变量
echo $SHELL         # 显示你在使用什么 SHELL

bash                # 使用 bash，用 exit 返回
whereis bash        # 查找 bash 在哪里
which bash          # 查找哪个程序对应命令 bash

clear               # 清初屏幕内容
reset               # 重置终端（当你不小心 cat 了一个二进制，终端状态乱掉时使用）


##############################################################################
# 目录操作
##############################################################################

cd                  # 返回自己 $HOME 目录
cd {dirname}        # 进入目录
pwd                 # 显示当前所在目录
mkdir {dirname}     # 创建目录
mkdir -p {dirname}  # 递归创建目录
pushd {dirname}     # 目录压栈并进入新目录
popd                # 弹出并进入栈顶的目录
dirs -v             # 列出当前目录栈
cd -                # 回到之前的目录
cd -{N}             # 切换到目录栈中的第 N个目录，比如 cd -2 将切换到第二个


##############################################################################
# 文件操作
##############################################################################

ls                  # 显示当前目录内容，后面可接目录名：ls {dir} 显示指定目录
ls -l               # 列表方式显示目录内容，包括文件日期，大小，权限等信息
ls -a               # 显示所有文件和目录，包括隐藏文件（.开头的文件/目录名）
ln -s {fn} {link}   # 给指定文件创建一个软链接
cp {src} {dest}     # 拷贝文件，cp -r dir1 dir2 可以递归拷贝（目录）
rm {fn}             # 删除文件，rm -r 递归删除目录，rm -f 强制删除
mv {src} {dest}     # 移动文件，如果 dest 是目录，则移动，是文件名则覆盖
touch {fn}          # 创建或者更新一下制定文件
cat {fn}            # 输出文件原始内容
any_cmd > {fn}      # 执行任意命令并将标准输出重定向到指定文件
more {fn}           # 逐屏显示某文件内容，空格翻页，q 退出
less {fn}           # 更高级点的 more，更多操作，q 退出
head {fn}           # 显示文件头部数行，可用 head -3 abc.txt 显示头三行
tail {fn}           # 显示文件尾部数行，可用 tail -3 abc.txt 显示尾部三行
tail -f {fn}        # 持续显示文件尾部数据，可用于监控日志
nano {fn}           # 使用 nano 编辑器编辑文件
vim {fn}            # 使用 vim 编辑文件
diff {f1} {f2}      # 比较两个文件的内容
wc {fn}             # 统计文件有多少行，多少个单词
chmod 644 {fn}      # 修改文件权限为 644，可以接 -R 对目录循环改权限
chown user1 {fn}    # 修改文件所有人为 user1, chown user1:group1 fn 可以修改组
grep {pat} {fn}     # 在文件中查找出现过 pat 的内容
grep -r {pat} .     # 在当前目录下递归查找所有出现过 pat 的文件内容


##############################################################################
# 用户管理
##############################################################################

whoami              # 显示我的用户名
passwd              # 修改密码，passwd {user} 可以用于 root 修改别人密码
finger {user}       # 显示某用户信息，包括 id, 名字, 登陆状态等
adduser {user}      # 添加用户
deluser {user}      # 删除用户
last {user}         # 显示登陆记录
w                   # 查看谁在线
su                  # 切换到 root 用户
su -                # 切换到 root 用户并登陆（执行登陆脚本）
su {user}           # 切换到某用户
su -{user}          # 切换到某用户并登陆（执行登陆脚本）
id {user}           # 查看用户的 uid，gid 以及所属其他用户组
id -u {user}        # 打印用户 uid
id -g {user}        # 打印用户 gid
write {user}        # 向某用户发送一句消息


##############################################################################
# 进程管理
##############################################################################

ps                        # 查看当前会话进程
ps ax                     # 查看所有进程，类似 ps -e
ps aux                    # 查看所有进程详细信息，类似 ps -ef
ps auxww                  # 查看所有进程，并且显示进程的完整启动命令
ps -u {user}              # 查看某用户进程
ps axjf                   # 列出进程树
ps -eo pid,user,command   # 按用户指定的格式查看进程
ps aux | grep httpd       # 查看名为 httpd 的所有进程
ps --ppid {pid}           # 查看父进程为 pid 的所有进程

kill {pid}                # 结束进程
kill -9 {pid}             # 强制结束进程，9/SIGKILL 是强制不可捕获结束信号
kill -KILL {pid}          # 强制执行进程，kill -9 的另外一种写法
kill -l                   # 查看所有信号
kill -l TERM              # 查看 TERM 信号的编号
killall {procname}        # 按名称结束进程

top                       # 查看最活跃的进程
top -u {user}             # 查看某用户最活跃的进程

any_command &             # 在后台运行某命令，也可用 CTRL+Z 将当前进程挂到后台
jobs                      # 查看所有后台进程（jobs）
bg                        # 查看后台进程，并切换过去
fg                        # 切换后台进程到前台
fg {job}                  # 切换特定后台进程到前台

trap cmd sig1 sig2        # 在脚本中设置信号处理命令
trap "" sig1 sig2         # 在脚本中屏蔽某信号
trap - sig1 sig2          # 恢复默认信号处理行为

disown {PID|JID}          # 将进程从后台任务列表（jobs）移除

wait                      # 等待所有后台进程任务结束


##############################################################################
# 常用命令：SSH / 系统信息 / 网络
##############################################################################

ssh user@host             # 以用户 user 登陆到远程主机 host
ssh -p {port} user@host   # 指定端口登陆主机
ssh-copy-id user@host     # 拷贝你的 ssh key 到远程主机，避免重复输入密码
scp {fn} user@host:path   # 拷贝文件到远程主机
scp user@host:path dest   # 从远程主机拷贝文件回来
scp -P {port} ...         # 指定端口远程拷贝文件

uname -a                  # 查看内核版本等信息
man {help}                # 查看帮助
info {help}               # 查看帮助，info pages，比 man 更强的帮助系统
uptime                    # 查看系统启动时间
date                      # 显示日期
cal                       # 显示日历
vmstat                    # 显示内存和 CPU 使用情况
vmstat 10                 # 每 10 秒打印一行内存和 CPU情况，CTRL+C 退出
free                      # 显示内存和交换区使用情况
df                        # 显示磁盘使用情况
du                        # 显示当前目录占用，du . --max-depth=2 可以指定深度
showkey -a                # 查看终端发送的按键编码

ping {host}               # ping 远程主机并显示结果，CTRL+C 退出
ping -c N {host}          # ping 远程主机 N 次
traceroute {host}         # 侦测路由连通情况
mtr {host}                # 高级版本 traceroute
whois {domain}            # 取得域名 whois 信息
dig {domain}              # 取得域名 dns 信息

wget {url}                # 下载文件，可加 --no-check-certificate 忽略 ssl 验证
wget -qO- {url}           # 下载文件并输出到标准输出（不保存）
curl -sL {url}            # 同 wget -qO- {url} 没有 wget 的时候使用

sz {file}                 # 发送文件到终端，zmodem 协议
rz                        # 接收终端发送过来的文件


##############################################################################
# 变量操作
##############################################################################

varname=value             # 定义变量
varname=value command     # 定义子进程变量并执行子进程
echo $varname             # 查看变量内容
echo $$                   # 查看当前 shell 的进程号
echo $!                   # 查看最近调用的后台任务进程号
echo $?                   # 查看最近一条命令的返回码
export VARNAME=value      # 设置环境变量（将会影响到子进程）

array[0]=valA             # 定义数组
array[1]=valB
array[2]=valC
array=([0]=valA [1]=valB [2]=valC)   # 另一种方式
array=(valA valB valC)               # 另一种方式

${array[i]}               # 取得数组中的元素
${#array[@]}              # 取得数组的长度
${#array[i]}              # 取得数组中某个变量的长度

declare -a                # 查看所有数组
declare -f                # 查看所有函数
declare -F                # 查看所有函数，仅显示函数名
declare -i                # 查看所有整数
declare -r                # 查看所有只读变量
declare -x                # 查看所有被导出成环境变量的东西
declare -p varname        # 输出变量是怎么定义的（类型+值）

${varname:-word}          # 如果变量不为空则返回变量，否则返回 word
${varname:=word}          # 如果变量不为空则返回变量，否则赋值成 word 并返回
${varname:?message}       # 如果变量不为空则返回变量，否则打印错误信息并退出
${varname:+word}          # 如果变量不为空则返回 word，否则返回 null
${varname:offset:len}     # 取得字符串的子字符串

${variable#pattern}       # 如果变量头部匹配 pattern，则删除最小匹配部分返回剩下的
${variable##pattern}      # 如果变量头部匹配 pattern，则删除最大匹配部分返回剩下的
${variable%pattern}       # 如果变量尾部匹配 pattern，则删除最小匹配部分返回剩下的
${variable%%pattern}      # 如果变量尾部匹配 pattern，则删除最大匹配部分返回剩下的
${variable/pattern/str}   # 将变量中第一个匹配 pattern 的替换成 str，并返回
${variable//pattern/str}  # 将变量中所有匹配 pattern 的地方替换成 str 并返回

${#varname}               # 返回字符串长度

*(patternlist)            # 零次或者多次匹配
+(patternlist)            # 一次或者多次匹配
?(patternlist)            # 零次或者一次匹配
@(patternlist)            # 单词匹配
!(patternlist)            # 不匹配

array=($text)             # 按空格分隔 text 成数组，并赋值给变量
IFS="/" array=($text)     # 按斜杆分隔字符串 text 成数组，并赋值给变量
text="${array[*]}"        # 用空格链接数组并赋值给变量
text=$(IFS=/; echo "${array[*]}")  # 用斜杠链接数组并赋值给变量

$(UNIX command)           # 运行命令，并将标准输出内容捕获并返回
varname=$(id -u user)     # 将用户名为 user 的 uid 赋值给 varname 变量

num=$(expr 1 + 2)         # 兼容 posix sh 的计算，使用 expr 命令计算结果
num=$(expr $num + 1)      # 数字自增
expr 2 \* \( 2 + 3 \)     # 兼容 posix sh 的复杂计算，输出 10

num=$((1 + 2))            # 计算 1+2 赋值给 num，使用 bash 独有的 $((..)) 计算
num=$(($num + 1))         # 变量递增
num=$((num + 1))          # 变量递增，双括号内的 $ 可以省略
num=$((1 + (2 + 3) * 2))  # 复杂计算


##############################################################################
# 函数
##############################################################################

# 定义一个新函数
function myfunc() {
	# $1 代表第一个参数，$N 代表第 N 个参数
	# $# 代表参数个数
	# $0 代表被调用者自身的名字
	# $@ 代表所有参数，类型是个数组 
	# $* 空格链接起来的所有参数，类型是字符串
	{shell commands ...}
}

myfunc                    # 调用函数 myfunc 
myfunc arg1 arg2 arg3     # 带参数的函数调用
unset -f myfunc           # 删除函数
declare -f                # 列出函数定义


##############################################################################
# 条件判断（兼容 posix sh 的条件判断）：man test
##############################################################################

statement1 && statement2  # and 操作符
statement1 || statement2  # or 操作符

exp1 -a exp2              # exp1 和 exp2 同时为真时返回真
exp1 -o exp2              # exp1 和 exp2 有一个为真就返回真
( expression )            # 如果 expression 为真时返回真，输入注意括号前反斜杆
! expression              # 如果 expression 为假那返回真

str1 = str2               # 判断字符串相等，如 [ "$x" = "$y" ] && echo yes
str1 != str2              # 判断字符串不等，如 [ "$x" != "$y" ] && echo yes
str1 < str2               # 字符串小于，如 [ "$x" \< "$y" ] && echo yes
str2 > str2               # 字符串大于，注意 < 或 > 是字面量，输入时要加反斜杆
-n str1                   # 判断字符串不为空（长度大于零）
-z str1                   # 判断字符串为空（长度等于零）

-a file                   # 判断文件存在，如 [ -a /tmp/abc ] && echo "exists"
-d file                   # 判断文件存在，且该文件是一个目录
-e file                   # 判断文件存在，和 -a 等价
-f file                   # 判断文件存在，且该文件是一个普通文件（非目录等）
-r file                   # 判断文件存在，且可读
-s file                   # 判断文件存在，且尺寸大于0
-w file                   # 判断文件存在，且可写
-x file                   # 判断文件存在，且执行
-N file                   # 文件上次修改过后还没有读取过
-O file                   # 文件存在且属于当前用户
-G file                   # 文件存在且匹配你的用户组
file1 -nt file2           # 文件1 比 文件2 新
file1 -ot file2           # 文件1 比 文件2 旧

num1 -eq num2             # 数字判断：num1 == num2
num1 -ne num2             # 数字判断：num1 != num2
num1 -lt num2             # 数字判断：num1 < num2
num1 -le num2             # 数字判断：num1 <= num2
num1 -gt num2             # 数字判断：num1 > num2
num1 -ge num2             # 数字判断：num1 >= num2


##############################################################################
# 分支控制：if 和经典 test，兼容 posix sh 的条件判断语句
##############################################################################

test {expression}         # 判断条件为真的话 test 程序返回0 否则非零
[ expression ]            # 判断条件为真的话返回0 否则非零

test "abc" = "def"        # 查看返回值 echo $? 显示 1，因为条件为假
test "abc" != "def"       # 查看返回值 echo $? 显示 0，因为条件为真

test -a /tmp; echo $?     # 调用 test 判断 /tmp 是否存在，并打印 test 的返回值
[ -a /tmp ]; echo $?      # 和上面完全等价，/tmp 肯定是存在的，所以输出是 0

test cond && cmd1         # 判断条件为真时执行 cmd1
[ cond ] && cmd1          # 和上面完全等价
[ cond ] && cmd1 || cmd2  # 条件为真执行 cmd1 否则执行 cmd2

# 判断 /etc/passwd 文件是否存在
# 经典的 if 语句就是判断后面的命令返回值为0的话，认为条件为真，否则为假
if test -e /etc/passwd; then
	echo "alright it exists ... "
else
	echo "it doesn't exist ... "
fi

# 和上面完全等价，[ 是个和 test 一样的可执行程序，但最后一个参数必须为 ]
# 这个名字为 "[" 的可执行程序一般就在 /bin 或 /usr/bin 下面，比 test 优雅些
if [ -e /etc/passwd ]; then   
	echo "alright it exists ... "
else
	echo "it doesn't exist ... "
fi

# 和上面两个完全等价
[ -e /etc/passwd ] && echo "alright it exists" || echo "it doesn't exist"

# 判断变量的值
if [ "$varname" = "foo" ]; then
	echo "this is foo"
elif [ "$varname" = "bar" ]; then
	echo "this is bar"
else
	echo "neither"
fi

# 复杂条件判断，注意，小括号是字面量，实际输入时前面要加反斜杆
if [ \( $x -gt 10 \) -a \( $x -lt 20 \) ]; then
	echo "yes, between 10 and 20"
fi

# 可以用 && 命令连接符来做和上面完全等价的事情
[ \( $x -gt 10 \) -a \( $x -lt 20 \) ] && echo "yes, between 10 and 20"

# 判断程序存在的话就执行
[ -x /bin/ls ] && /bin/ls -l

# 如果不考虑兼容 posix sh 和 dash 这些的话，可用 bash 独有的 ((..)) 和 [[..]]:
https://www.ibm.com/developerworks/library/l-bash-test/index.html


##############################################################################
# 流程控制：while / for / case / until 
##############################################################################

# while 循环
while condition; do
	statements
done

i=1
while [ $i -le 10 ]; do
	echo $i; 
	i=$(expr $i + 1)
done

# for 循环：上面的 while 语句等价
for i in {1..10}; do
	echo $i
done

for name [in list]; do
	statements
done

# for 列举某目录下面的所有文件
for f in /home/*; do 
	echo $f
done

# bash 独有的 (( .. )) 语句，更接近 C 语言，但是不兼容 posix sh
for (( initialisation ; ending condition ; update )); do
	statements
done

# 和上面的写法等价
for ((i = 0; i < 10; i++)); do echo $i; done

# case 判断
case expression in 
	pattern1 )
		statements ;;
	pattern2 )
		statements ;;
	* )
		otherwise ;;
esac

# until 语句
until condition; do
	statements
done

# select 语句
select name [in list]; do
  statements that can use $name
done


##############################################################################
# 命令处理
##############################################################################

command ls                         # 忽略 alias 直接执行程序或者内建命令 ls
builtin cd                         # 忽略 alias 直接运行内建的 cd 命令
enable                             # 允许或者禁止 bash 的内建命令

eval $script                       # 对 script 变量中的字符串求值（执行）


##############################################################################
# 输出/输入 重定向
##############################################################################

cmd1 | cmd2                        # 管道，cmd1 的标准输出接到 cmd2 的标准输入
< file                             # 将文件内容重定向为命令的标准输入
> file                             # 将命令的标准输出重定向到文件，会覆盖文件
>> file                            # 将命令的标准输出重定向到文件，追加不覆盖
>| file                            # 强制输出到文件，即便设置过：set -o noclobber
n>| file                           # 强制将文件描述符 n的输出重定向到文件
<> file                            # 同时使用该文件作为标准输入和标准输出
n<> file                           # 同时使用文件作为文件描述符 n 的输出和输入
n> file                            # 重定向文件描述符 n 的输出到文件
n< file                            # 重定向文件描述符 n 的输入为文件内容
n>&                                # 将标准输出 dup/合并 到文件描述符 n
n<&                                # 将标准输入 dump/合并 定向为描述符 n
n>&m                               # 文件描述符 n 被作为描述符 m 的副本，输出用
n<&m                               # 文件描述符 n 被作为描述符 m 的副本，输入用
&>file                             # 将标准输出和标准错误重定向到文件
<&-                                # 关闭标准输入
>&-                                # 关闭标准输出
n>&-                               # 关闭作为输出的文件描述符 n
n<&-                               # 关闭作为输入的文件描述符 n


##############################################################################
# 文本处理 - cut
##############################################################################

cut -c 1-16                        # 截取每行头16个字符
cut -c 1-16 file                   # 截取指定文件中每行头 16个字符
cut -c3-                           # 截取每行从第三个字符开始到行末的内容
cut -d':' -f5                      # 截取用冒号分隔的第五列内容
cut -d';' -f2,10                   # 截取用分号分隔的第二和第十列内容
cut -d' ' -f3-7                    # 截取空格分隔的三到七列
echo "hello" | cut -c1-3           # 显示 hel
echo "hello sir" | cut -d' ' -f2   # 显示 sir
ps | tr -s " " | cut -d " " -f 2,3,4  # cut 搭配 tr 压缩字符


##############################################################################
# 文本处理 - awk / sed 
##############################################################################

awk '{print $5}' file              # 打印文件中以空格分隔的第五列
awk -F ',' '{print $5}' file       # 打印文件中以逗号分隔的第五列
awk '/str/ {print $2}' file        # 打印文件中包含 str 的所有行的第二列
awk -F ',' '{print $NF}' file      # 打印逗号分隔的文件中的每行最后一列 
awk '{s+=$1} END {print s}' file   # 计算所有第一列的合
awk 'NR%3==1' file                 # 从第一行开始，每隔三行打印一行

sed 's/find/replace/' file         # 替换文件中首次出现的字符串并输出结果 
sed -r 's/regex/replace/g' file    # 替换文件中所有出现的字符串
sed -i 's/find/replace/g' file     # 替换文件中所有出现的字符并且覆盖文件
sed '/line/s/find/replace/' file   # 先搜索行特征再执行替换
sed -e 's/f/r/' -e 's/f/r' file    # 执行多次替换
sed 's#find#replace#' file         # 使用 # 替换 / 来避免 pattern 中有斜杆
sed -i -r 's/^\s+//g' file         # 删除文件每行头部空格
sed '/^$/d' file                   # 删除文件空行并打印
sed -i 's/\s\+$//' file            # 删除文件每行末尾多余空格


##############################################################################
# 排序 - sort
##############################################################################

sort file                          # 排序文件
sort -r file                       # 反向排序（降序）
sort -n file                       # 使用数字而不是字符串进行比较
sort -t: -k 3n /etc/passwd         # 按 passwd 文件的第三列进行排序
sort -u file                       # 去重排序


##############################################################################
# 快速跳转 - https://github.com/rupa/z
##############################################################################

source /path/to/z.sh               # .bashrc 中初始化 z.sh
z                                  # 列出所有历史路径以及他们的权重
z foo                              # 跳到历史路径中匹配 foo 的权重最大的目录
z foo bar                          # 跳到历史路径中匹配 foo 和 bar 权重最大的目录
z -l foo                           # 列出所有历史路径中匹配 foo 的目录及权重
z -r foo                           # 按照最高访问次数优先进行匹配跳转
z -t foo                           # 按照最近访问优先进行匹配跳转


##############################################################################
# 键盘绑定
##############################################################################

bind '"\eh":"\C-b"'                # 绑定 ALT+h 为光标左移，同 CTRL+b / <Left>
bind '"\el":"\C-f"'                # 绑定 ALT+l 为光标右移，同 CTRL+f / <Right>
bind '"\ej":"\C-n"'                # 绑定 ALT+j 为下条历史，同 CTRL+n / <Down>
bind '"\ek":"\C-p"'                # 绑定 ALT+k 为上条历史，同 CTRL+p / <Up>
bind '"\eH":"\eb"'                 # 绑定 ALT+H 为光标左移一个单词，同 ALT-b 
bind '"\eL":"\ef"'                 # 绑定 ALT+L 为光标右移一个单词，同 ALT-f 
bind '"\eJ":"\C-a"'                # 绑定 ALT+J 为移动到行首，同 CTRL+a / <Home>
bind '"\eK":"\C-e"'                # 绑定 ALT+K 为移动到行末，同 CTRL+e / <End>
bind '"\e;":"ls -l\n"'             # 绑定 ALT+; 为执行 ls -l 命令


##############################################################################
# 有趣的命令
##############################################################################

man hier                           # 查看文件系统的结构和含义
man test                           # 查看 posix sh 的条件判断帮助
man ascii                          # 显示 ascii 表
getconf LONG_BIT                   # 查看 32 位还是 64 位
bind -P                            # 列出所有 bash 的快捷键
mount | column -t                  # 漂亮的列出当前加载的文件系统
curl ip.cn                         # 取得外网 ip 地址和服务商信息
disown -a && exit                  # 关闭所有后台任务并退出
cat /etc/issue                     # 查看 Linux 发行版信息
lsof -i port:80                    # 哪个程序在使用 80 端口？
showkey -a                         # 取得按键的 ASCII 码
svn diff | view -                  # 使用 Vim 来显示带色彩的 diff 输出
mv filename.{old,new}              # 快速文件改名
time read                          # 使用 CTRL-D 停止，最简单的计时功能
cp file.txt{,.bak}                 # 快速备份文件
sudo touch /forcefsck              # 强制在下次重启时扫描磁盘
find ~ -mmin 60 -type f            # 查找 $HOME 目录中，60 分钟内修改过的文件
curl wttr.in/~beijing              # 查看北京的天气预报
echo ${SSH_CLIENT%% *}             # 取得你是从什么 IP 链接到当前主机上的
echo $[RANDOM%X+1]                 # 取得 1 到 X 之间的随机数
bind -x '"\C-;":ls -l'             # 设置 CTRL+C 为执行 ls -l 命令
find / -type f -size +5M           # 查找大于 5M 的文件
chmod --reference f1 f2            # 将 f2 的权限设置成 f1 一模一样的


##############################################################################
# 常用技巧
##############################################################################

# 列出最常使用的命令
history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head

# 通过 SSH 来 mount 文件系统
sshfs name@server:/path/to/folder /path/to/mount/point

# 显示前十个运行的进程并按内存使用量排序
ps aux | sort -nk +4 | tail

# 在右上角显示时钟
while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done&

# 从网络上的压缩文件中解出一个文件来，并避免保存中间文件
wget -qO - "http://www.tarball.com/tarball.gz" | tar zxvf -

# 性能测试：测试处理器性能
python -c "import test.pystone;print(test.pystone.pystones())"

# 性能测试：测试内存带宽
dd if=/dev/zero of=/dev/null bs=1M count=32768

# Linux 下挂载一个 iso 文件
mount /path/to/file.iso /mnt/cdrom -oloop

# 通过主机 A 直接 ssh 到主机 B
ssh -t hostA ssh hostB

# 下载一个网站的所有图片
wget -r -l1 --no-parent -nH -nd -P/tmp -A".gif,.jpg" http://example.com/images

# 快速创建项目目录
mkdir -p work/{project1,project2}/{src,bin,bak}

# 按日期范围查找文件
find . -type f -newermt "2010-01-01" ! -newermt "2010-06-01"

# 显示当前正在使用网络的进程
lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2

# Vim 中保存一个没有权限的文件
:w !sudo tee > /dev/null %


##############################################################################
# 有用的函数
##############################################################################

# 自动解压：判断文件后缀名并调用相应解压命令
function q-extract() {
	if [ -f $1 ] ; then
		case $1 in
		*.tar.bz2)   tar -xvjf $1    ;;
		*.tar.gz)    tar -xvzf $1    ;;
		*.tar.xz)    tar -xvJf $1    ;;
		*.bz2)       bunzip2 $1     ;;
		*.rar)       rar x $1       ;;
		*.gz)        gunzip $1      ;;
		*.tar)       tar -xvf $1     ;;
		*.tbz2)      tar -xvjf $1    ;;
		*.tgz)       tar -xvzf $1    ;;
		*.zip)       unzip $1       ;;
		*.Z)         uncompress $1  ;;
		*.7z)        7z x $1        ;;
		*)           echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# 自动压缩：判断后缀名并调用相应压缩程序
function q-compress() {
	if [ -n "$1" ] ; then
		FILE=$1
		case $FILE in
		*.tar) shift && tar -cf $FILE $* ;;
		*.tar.bz2) shift && tar -cjf $FILE $* ;;
		*.tar.xz) shift && tar -cJf $FILE $* ;;
		*.tar.gz) shift && tar -czf $FILE $* ;;
		*.tgz) shift && tar -czf $FILE $* ;;
		*.zip) shift && zip $FILE $* ;;
		*.rar) shift && rar $FILE $* ;;
		esac
	else
		echo "usage: q-compress <foo.tar.gz> ./foo ./bar"
	fi
}


##############################################################################
# References
##############################################################################

http://www.linuxstall.com/linux-command-line-tips-that-every-linux-user-should-know/
https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh
https://ss64.com/bash/syntax-keyboard.html
http://wiki.bash-hackers.org/commands/classictest
https://www.ibm.com/developerworks/library/l-bash-test/index.html
https://www.cyberciti.biz/faq/bash-loop-over-file/
https://linuxconfig.org/bash-scripting-tutorial
https://devhints.io/bash
https://github.com/jlevy/the-art-of-command-line



