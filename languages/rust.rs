/*******************************************************************************
 * Rust CHEATSHEET (中文速查表)  -  by Shieber (created on 2022/04/17)
 * Version: 1, Last Modified: 2022/04/17 13:08
 * https://github.com/skywind3000/awesome-cheatsheets
 ******************************************************************************/

/******************************************************************************
 * rustc 编译器命令
 *****************************************************************************/
rustc [options] input                               // rustc [参数] 输入
rustc file.rs                                       // 编译 crate
rustc --cfg 'verbose'                               // 配置编译环境
rustc --cfg 'feature="serde"'                       // 配置编译环境
rustc -L                                            // 将目录添加到库搜索路径
rustc -l                                            // 将生成的 crate 链接到本地库
rustc --crate-type rlib                             // 向编译器指明要构建的 crate 类型
rustc --crate-name name                             // 向编译器指明要构建的 crate 名称
rustc --edition 2021                                // 向编译器指明要使用的语义版本
rustc --emit mir                                    // 向编译器指明输出文件的类型
rustc --print                                       // 打印编译器信息
rustc -g                                            // 包含调试信息、等同于使用 -C debuginfo=2
rustc -O                                            // 优化代码、等同于 -C opt-level=2
rustc -o                                            // 指定输出文件名
rustc --out-dir dir                                 // 将输出写入的目录
rustc --explain discription                         // 提供错误消息的详细说明
rustc --test                                        // 构建测试工具
rustc --target TARGET                               // 选择要构建目标的三要素
rustc -A                                            // 设置 lint 许可等级
rustc -W                                            // 设置 lint 警告等级
rustc -D                                            // 设置 lint 拒绝等级
rustc -F                                            // 设置 lint 禁止等级
rustc -C                                            // 代码生成选项
rustc -V                                            // 输出版本
rustc -v                                            // 详细输出编译信息
rustc --extern dir                                  // 指定外部库的位置

/******************************************************************************
 * cargo 工具命令
 *****************************************************************************/
cargo [+toolchain] [options] [subcommand]           // cargo [工具链] [参数] [子命令]
cargo -V                                            // 输出版本信息
cargo -list                                         // 输出 cargo 安装的命令
cargo --explain code                                // 调用 rustc --explian code 输出解析信息
cargo -v                                            // 输出详细信息
cargo -q                                            // 不输出日志信息
cargo --color when                                  // 设置是否输出颜色，when 对应 auto、always、never
cargo --frozen                                      // 冻结版本，禁止升级
cargo --locked                                      // 锁定版本，禁止升级
cargo --offline                                     // 离线运行
cargo --config key=value                            // 覆盖默认的配置值
cargo -Z flag                                       // 开启 unstable 特性
cargo -h                                            // 输出帮助信息
cargo build                                         // 编译包及其依赖项
cargo run                                           // 编译并运行
cargo bench                                         // 执行包中的所有 benchmark
cargo test                                          // 运行包中的所有测试
cargo check                                         // 检查包并报告错误
cargo clean                                         // 清除 target 目录
cargo clippy                                        // 检查包代码的错误，用于提升代码质量
cargo doc                                           // 生成构建包及其依赖的文档
cargo fix                                           // 自动修复 rustc 抛出的警告
cargo flamegraph                                    // 生成火焰图
cargo fmt                                           // 调用 cargofmt 来格式化代码
cargo new                                           // 新建一个包
cargo init                                          // 在某目录下新建包
cargo install                                       // 安装库到 $HOME/.cargo/bin 下
cargo uninstall                                     // 移除安装的库
cargo update                                        // 更新 Cargo.lock 里的依赖
cargo search                                        // 搜索 crates.io 上注册过的 crate
cargo publish                                       // 打包并发布到 crates.io

/*******************************************************************************
 * Package
 *******************************************************************************/
cargo new name --lib                                // 新建名为 name 的库
cargo new name --bin                                // 新建名为 name 的二进制文件
Cargo.toml                                          // 依赖文件及其他选项配置
Cargo.lock                                          // 依赖管理

/******************************************************************************
 * 关键字
 *****************************************************************************/
Self      enum     match   super
as        extern   mod     trait
async     false    move    true
await     fn       mut     type
break     for      pub     union
const     if       ref     unsafe
continue  impl     return  use
crate     in       self    where
dyn       let      static  while
else      loop     struct

/*******************************************************************************
 * 基本数据类型
 *******************************************************************************/
bool                                                // 布尔
char                                                // 字符
str                                                 // 不可变序列
&str                                                // str 的引用
String                                              // 动态字符串
tuple                                               // 元组
array                                               // 数组
slice                                               // 切片
isize                                               // 有符号整型 (32位操作系统上为i32，64位操作系统上为i64)
i8                                                  // 8位有符号整型
i16                                                 // 16位有符号整型
i32                                                 // 32位有符号整型
i64                                                 // 64位有符号整型
usize                                               // 无符号整型(32位操作系统上为u32，64位操作系统上为u64)
u8                                                  // 8位无符号整型
u16                                                 // 16位无符号整型
u32                                                 // 32位无符号整型
u64                                                 // 64位无符号整型
f32                                                 // 32位浮点数，精确到小数点后7位
f64                                                 // 64位浮点数，精确到小数点后15位

/*******************************************************************************
 * Hello World
 ******************************************************************************/
// main.rs

fn main() {                                         // 主函数
    println!("Hello World!")                        // println! 宏打印输出
}
// rustc main.rs                                    // 编译
// ./main                                           // 运行


/*******************************************************************************
 * 操作符
 ******************************************************************************/
// 算数操作符
+ - * / %                                           // 加 减 乘 除 取余
& | ^                                               // 位与 位或 位异或 位与非
<< >>                                               // 左移 右移
+= -= *= /= %=                                      // 加 减 乘 除 取余 [带赋值功能]
&= |= ^=                                            // 位与 位或 位异或 [带赋值功能]
<<= >>=                                             // 左移 右移 [带赋值功能]

// 比较操作
== !=                                               // 等于 不等于
< <=                                                // 小于 小于等于
> >=                                                // 大于 大于等于

// 逻辑操作
&& || !                                             // 逻辑与 逻辑或 逻辑非

// 其他
& * -> => @                                         // 引用 解引用 表示返回值 模式匹配 模式绑定

/*******************************************************************************
 * 变量声明
 ******************************************************************************/
let a = 1                                           // 直接声明一个变量，类新自动推导
let mut b: i8 = 1                                   // 直接声明一个可变量，指定类型
const d = 1                                         // 常量

/*******************************************************************************
 * 数据类型
 ******************************************************************************/
let s = "hello"                                     // &str
let c = 'c'                                         // 字符
let a = 1                                           // int
let b = 1.2                                         // float64

let arr1 = [0; 5]                                   // 手动指定数组长度
let arr2 = [0,0,0,0,0]                              // 由 rust 自动计算长度

let sliceInt = &arr2[..3]                           // 切片

let a = &arr1                                       // 引用
let a = &arr2[..2]                                  // 部分引用

/*******************************************************************************
 * 流程控制
 ******************************************************************************/
// for/for in
for i > 0 {
    println!("{i}");
    i -= 1;
}

for i in arr {
    println!("{i}");
}

// if/else if/else
if i == 10 {
    println!("i == 10")
} else {
    println!("i != 10")
}

// if let/let if
let a = if i > 5 { 2 } else { 3 };
if let Some(x) = k { x; } else { println!("0"); };
if let Some(value) = k {
    println!("{:?}", value);
}

// match
match xx {
    None => { xxx },
    Some(x) => { xxx },
}

// while
while a > 10 {
    println!("{a}");
    a -= 1;
}

while Some(x) = k {
    println!("{:?}", x;)
}

// loop
loop {
    if i > 10 {
        break;
    }

    println!("{i}");
    i += 1;
}

/*******************************************************************************
 * 函数
 ******************************************************************************/
// 以 fn 关键字声明
fn function(var1: type, var2: type) -> returnType {
    codeBody;
    returnValue
}

// 闭包函数
let f = |x, y| { codeBody; returnValue }
f()

// 函数多返回值
fn get() -> (type1, type2)  {
    codeBody;
    (value1, value2)
}

/*******************************************************************************
 * 结构体
 ******************************************************************************/
// rust 中没有class只有struct
struct People {
  age: u8
  pub name: String                        // pub 开头的变量可在包外访问
}

let p1 = People{                          // 最好按照结构体内部定义的顺序
    age: 25,
    name: "Kaven".to_string()
}

let age = 20;
let p1 = People{                          // 有同名变量，直接使用
    age,
    name: "Shieber".to_string()
}

/*******************************************************************************
 * 方法
 ******************************************************************************/
// 方法通常是针对一个 trait 来说的
trait Foo {
    fn get(x: type1, y: type2) -> returnType;
}

impl Foo for xx {}

// xx 重载 get 方法
impl xx {
    fn get(x: type1, y: type2) -> returnType {
        codeBody;
        returnValue
    }
}

/*******************************************************************************
 * Trait
 ******************************************************************************/
// rust 的 trait 类似其他语言的接口这个概念
trait Reader {
    fn reading();                         // 实现 reading 方法就实现了接口 Reader
}

impl Reader for xx {
    fn reading() -> returnType {
        codeBody;
        returnValue
    }
}

/*******************************************************************************
 * 泛型
 ******************************************************************************/
fn add<T>(x: T, y: T) -> T {
    x + y
}

fn main() {
    let a = 1;
    let b = 2;
    let c = 1.0;
    let d = 2.0;
    let e = add(a, b);
    let f = add(c, d);
    println!("{e}, {f}");
}

/*******************************************************************************
 * 函数式编程
 ******************************************************************************/
fn main() {
    // 求小于1000的能被3或5整除的所有整数之和
    let sum = (1..1000).filter(|n| n % 3 == 0 || n % 5 == 0).sum::<u32>();
    println!("{sum}");
}

/*******************************************************************************
 * 异常处理
 ******************************************************************************/
use std::fs::File;
use std::fs::io;
use std::fs::io::ErrorKind;
use std::fs::Read;

fn main() {
    let f = Fill::oepn("test.txt");
    let f = match f {
        Ok(file) => file,
        Err(err) => match err.kind() {
            ErrorKind::NotFound => match Fill::crate("test.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Error while creating file!"),
            }
            ErrorKind::PermissionDenied => panic!("PermissionDenied"),
            other => panic!("Error while openning file!"),
        }
    }

    let a = Fill::oepn("test.txt").unwrap(); // 直接 unwrap，不用 match，有错报错
    let b = Fill::oepn("test.txt").expect("Error while openning file!"); // 添加额外错误信息
    let c = Fill::oepn("test.txt")?; // 将错误往上抛
}

/*******************************************************************************
 * 宏系统
 ******************************************************************************/
// 宏定义格式
macro_rules! macro_name {
    ($matcher) => {
        $code_body;
        return_value
    };
}

// 求树的左子节点
macro_rules! left_child {
    ($parent:ident) => {
        $parent << 1
    };
}

// 求树的右子节点
macro_rules! right_child {
    ($parent:ident) => {
        ($parent << 1) + 1
    };
}

/*******************************************************************************
 * 资源整理
 ******************************************************************************/
// 入门书籍
《Rust 程序设计语言》                // 官方出品
《深入浅出 Rust》                    // 推荐
《Rust 语言圣经》                    // 推荐

// 进阶书籍/文档
《Cargo 教程》
《Rust 编程之道》
《rustc 手册》
《Rust 死灵书》
《Rust 异步编程》

// 特定领域
Wasm: https://wasmer.io、https://wasmtime.dev、https://wasmedge.org
HTTP/3: https://github.com/cloudflare/quiche
coreutils: https://github.com/uutils/coreutils
算法: https://github.com/TheAlgorithms/Rust
游戏: https://github.com/bevyengine/bevy
工具: https://github.com/rustdesk/rustdesk
区块链: https://github.com/w3f/polkadot
数据库: https://github.com/tikv、https://github.com/tensorbase/tensorbase
编译器: https://github.com/rust-lang/rustc_codegen_gcc
操作系统: https://github.com/Rust-for-Linux、https://github.com/rcore-os
Web 前端: https://github.com/yewstack/yew、 https://github.com/denoland/deno
Web 后端: https://actix.rs/、 https://github.com/tokio-rs/axum、 https://github.com/poem-web/poem

// 资源网站
Rust 官网: https://www.rust-lang.org
Rust 源码: https://github.com/rust-lang/rust
Rust 文档: https://doc.rust-lang.org/stable
Rust 参考: https://doc.rust-lang.org/reference
Rust 杂志: https://rustmagazine.github.io/rust_magazine_2021
Rust 库/箱: https://crates.io、https://lib.rs
Rust 中文社区: https://rustcc.cn
Rust 乐酷论坛: https://learnku.com/rust
Rust 资料搜集: https://www.yuque.com/zhoujiping/programming/rust-materials
Rust LeetCode: https://rustgym.com/leetcode
Awesome Rust: https://github.com/rust-unofficial/awesome-rust
Rust Cheat Sheet: https://cheats.rs
芽之家: https://books.budshome.com
令狐壹冲: https://space.bilibili.com/485433391
