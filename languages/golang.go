/*******************************************************************************
 * Golang CHEATSHEET (中文速查表)  -  by chlins (created on 2018/02/14)
 * Version: 3, Last Modified: 2018/03/07 19:51
 * https://github.com/skywind3000/awesome-cheatsheets
 ******************************************************************************/



 /******************************************************************************
  * Go 编译器命令
  *****************************************************************************/
go command [arguments]                              // go 命令 [参数]
go build                                            // 编译包和依赖包
go clean                                            // 移除对象和缓存文件
go doc                                              // 显示包的文档
go env                                              // 打印go的环境变量信息
go bug                                              // 报告bug
go fix                                              // 更新包使用新的api
go fmt                                              // 格式规范化代码
go generate                                         // 通过处理资源生成go文件
go get                                              // 下载并安装包及其依赖
go install                                          // 编译和安装包及其依赖
go list                                             // 列出所有包
go run                                              // 编译和运行go程序
go test                                             // 测试
go tool                                             // 运行给定的go工具
go version                                          // 显示go当前版本
go vet                                              // 发现代码中可能的错误

/*******************************************************************************
* ENV
*******************************************************************************/
GOOS                                                  // 编译系统
GOARCH                                                // 编译arch
GO111MODULE                                           // gomod开关
GOPROXY                                               // go代理 https://goproxy.io  https://goproxy.cn
GOSSAFUNC                                             // 生成SSA.html文件，展示代码优化的每一步 GOSSAFUNC=func_name go build

/*******************************************************************************
 * Module
 *******************************************************************************/
go mod init                                           // 初始化当前文件夹，创建go.mod文件
go mod download                                       // 下载依赖的module到本地
go mod tidy                                           // 增加缺少的module，删除无用的module
go mod vendor 					                              // 将依赖的包复制到vendor文件夹下
文件go.mod                                             // 依赖列表和版本约束
文件go.sum                                             // 记录module文件hash值，用于安全校验


/*******************************************************************************
 * 基本数据类型
 *******************************************************************************/
bool                                                   // 布尔
string                                                 // 字符串
int                                                    // 无符号整型(32位操作系统上为int32，64位操作系统上为int64)
int8                                                   // 8位无符号整型
int16                                                  // 16位无符号整型
int32                                                  // 32位无符号整型
int64                                                  // 64位无符号整型
uint                                                   // 有符号整型(32位操作系统上为uint32，64位操作系统上为uint64)
uint8                                                  // 8位有符号整型
uint16                                                 // 16位有符号整型
uint32                                                 // 32位有符号整型
uint64                                                 // 64位有符号整型
float32                                                // 32位浮点数，精确到小数点后7位
float64                                                // 64位浮点数，精确到小数点后15位
complex64                                              // 32位实数和虚数
complex128                                             // 64位实数和虚数
byte                                                   // 类型实际是一个uint8，代表了ASCII码的一个字符
rune                                                   // 类型实际是一个int32，代表一个UTF-8字符


/*******************************************************************************
 * Hello World
 ******************************************************************************/
// main.go
package main                                        // 包名

import "fmt"                                        // 导入fmt包

func main() {                                       // 主函数
    fmt.Println("Hello World")                      // 打印输出
}
// go run main.go                                   // 直接运行
// go build && ./main                               // 先编译成二进制文件再运行



/*******************************************************************************
 * 操作符
 ******************************************************************************/
// 算数操作符
+ - * / %                                           // 加 减 乘 除 取余
& | ^ &^                                            // 位与 位或 位异或 位与非
<< >>                                               // 左移 右移
// 比较操作
== !=                                               // 等于 不等于
< <=                                                // 小于 小于等于
> >=                                                // 大于 大于等于
// 逻辑操作
&& || !                                             // 逻辑与 逻辑或 逻辑非
// 其他
& * <-                                              // 地址 指针引用 通道操作



/*******************************************************************************
 * 声明
 ******************************************************************************/
a := 1                                              // 直接给一个未声明的变量赋值
var b int                                           // var 变量名 数据类型 来声明
var c float64
// 注意：使用var声明过的变量不可再使用 := 赋值
a = 2
const d = 1                                         // 常量



/*******************************************************************************
 * 测试
 ******************************************************************************/
// 要测试的接口
package testdemo

func Adder(a int, b int) int {
	return a + b
}

// 编写test
package testdemo

import "testing"

func TestPass(t *testing.T) {
	expected := 3
	if observed := Adder(1, 2); observed != expected {
		t.Fatalf("Adder(1, 2) = %v, want %v", observed, expected)
	}
}

func TestSkip(t *testing.T) {
	t.Skip("Skipping test")
}

func TestFail(t *testing.T) {
	expected := 3
	if observed := Adder(2, 2); observed != expected {
		t.Fatalf("Adder(2, 2) = %v, want %v", observed, expected)
	}
}

// 运行命令
go test -v mod/{package_name}


/*******************************************************************************
 * 数据类型
 ******************************************************************************/
s := "hello"                                       // 字符
a := 1                                             // int
b := 1.2                                           // float64
c := 1 + 5i                                        // complex128
// 数组
arr1 := [3]int{4, 5, 6}                           // 手动指定长度
arr2 := [...]int{1, 2, 3}                         // 由golang自动计算长度
// 切片
sliceInt := []int{1, 2}                           // 不指定长度
sliceByte := []byte("hello")
// 指针
a := 1
point := &a                                      // 将a的地址赋给point


/*******************************************************************************
 * 流程控制
 ******************************************************************************/
// for
i := 10
for i > 0 {
    println(i--)
}
// if else
if i == 10 {
    println("i == 10")
} else {
    println("i != 10")
}
// if with init 
m := map[int]int{1:1}
if v, ok := m[1]; ok {
    println(v)
}
// switch
switch i {
case 10:
    println("i == 10")
default:
    println("i != 10")
}
// 三目表达式
注意：Golang没有三目表达式


/*******************************************************************************
 * 函数
 ******************************************************************************/
// 以func关键字声明
func test() {}

f := func() {println("Lambdas function")}     // 匿名函数
f()

func get() (a,b string) {                    // 函数多返回值
    return "a", "b"
}
a, b := get()




/*******************************************************************************
 * 结构体
 ******************************************************************************/
// golang中没有class只有struct
type People struct {
  Age int                                  // 大写开头的变量在包外可以访问
  name string                              // 小写开头的变量仅可在本包内访问
}
p1 := People{25, "Kaven"}                 // 必须按照结构体内部定义的顺序
p2 := People{name: "Kaven", age: 25}      // 若不按顺序则需要指定字段

// 也可以先不赋值
p3 := new(People)
p3.Age = 25
p3.name = "Kaven"


/*******************************************************************************
 * 方法
 ******************************************************************************/
// 方法通常是针对一个结构体来说的
type Foo struct {
  a int
}
                                        // 值接收者
func (f Foo) test() {
  f.a = 1                              // 不会改变原来的值
}
                                      // 指针接收者
func (f *Foo) test() {
  f.a = 1                            // 会改变原值
}



/*******************************************************************************
 * go 协程
 ******************************************************************************/
go func() {
    time.Sleep(10 * time.Second)
    println("hello")
}()                                // 不会阻塞代码的运行 代码会直接向下运行
// channel 通道
c := make(chan int)
// 两个协程间可以通过chan通信
go func() {c <- 1}()              // 此时c会被阻塞 直到值被取走前都不可在塞入新值
go func() {println(<-c)}()
// 带缓存的channel
bc := make(chan int, 2)
go func() {c <- 1; c <-2}()      // c中可以存储声明时所定义的缓存大小的数据，这里是2个
go func() {println(<-c)}()



/*******************************************************************************
 * 接口
 ******************************************************************************/
// go的接口为鸭子类型，即只要你实现了接口中的方法就实现了该接口
type Reader interface {
    Reading()                  // 仅需实现Reading方法就实现了该接口
}

type As struct {}
func (a As) Reading() {}      // 实现了Reader接口

type Bs struct {}
func (b Bs) Reading() {}      // 也实现了Reader接口
func (b Bs) Closing() {}


/*******************************************************************************
 * 泛型（v1.18）
 ******************************************************************************/
func Sum[T int | float32 | float64](x, y T) T {
	return x + y
}

type Number interface {
	int | int32 | int64 | float64 | float32
}

type SliceAdditon[T Number] struct {
	data []T
}

func (sa *SliceAdditon[T]) Sum() T {
	var sum T
	for _, v := range sa.data {
		sum += v
	}
	return sum
}

func Caller() {
	sInt := Sum(1, 2)       // Sum[int]
	sFloat := Sum(1.1, 2.2) // Sum[float64]
	println(sInt, sFloat)

	saInt := SliceAdditon[int]{data: []int{1, 2, 3, 4, 5}}
	saFloat64 := SliceAdditon[float64]{data: []float64{1.1, 2.2, 3.3, 4.4, 5.5}}
	println(saInt.Sum())
	println(saFloat64.Sum())
}

/*******************************************************************************
 * 一些推荐
 ******************************************************************************/
// 入门书籍
《Go学习笔记》                // 雨痕的
《Go语言实战》                // 强烈推荐
// 网上资料
https://github.com/astaxie/build-web-application-with-golang    // 谢大的
https://github.com/Unknwon/the-way-to-go_ZH_CN                  // 无闻
https://github.com/Unknwon/go-fundamental-programming           // 无闻教学视频
// 大杂烩
https://github.com/avelino/awesome-go



/*******************************************************************************
 * References
 ******************************************************************************/
https://github.com/a8m/go-lang-cheat-sheet
https://github.com/LeCoupa/awesome-cheatsheets
https://github.com/jonasbn/go-test-demo