/**
 * Golang CHEATSHEET (中文速查表)  -  by chlins (created on 2018/02/14)
 * Version: 1, Last Modified: 2018/02/28 16:51
 * https://github.com/skywind3000/awesome-cheatsheets
 */


/**
 * Hello World
 */
package main

import "fmt"

func main() {
  fmt.Println("Hello World")
}
// go run main.go


/**
 * 变量声明
 */
// 直接使用 := 来给一个未声明的变量赋值
a := 1
// 通过 var 变量名 数据类型 来声明
var a int
a = 1
// 注意：使用var声明过的变量不可再使用 := 赋值


/**
 * 常量
 */
// 常量直接使用 const 声明
const a = 1 // golang 会自动推倒类型


/**
 * 数据类型
 */
// 字符
s := "hello"
// 数值
a := 1 // int
b := 1.2 // float64
c := 1 + 5i // complex128
// 数组
arr1 := [3]int{4, 5, 6}  // 手动指定长度
arr2 := [...]int{1, 2, 3} // 由golang自动计算长度
// 切片
sliceInt := []int{1, 2} // 不指定长度
sliceByte := []byte("hello")
// 指针
a := 1
point := &a // 将a的地址赋给point


/**
 * 流程控制
 */
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
// switch
switch i {
case 10:
  println("i == 10")
default:
  println("i != 10")
}


/**
 * 函数
 */
// 以func关键字声明
func test() {}
// 匿名函数
f := func() {println("Lambdas function")}
f()
// 函数多返回值
func get() (a,b string) {
  return "a", "b"
}
a, b := get()

/**
 * 结构体
 */
// golang中没有class只有struct
type People struct {
  Age int        // 大写开头的变量在包外可以访问
  name string    // 小写开头的变量仅可在本包内访问
}
p1 := People{25, "Kaven"}  // 必须按照结构体内部定义的顺序
p2 := People{name: "Kaven", age: 25}  // 若不按顺序则需要指定字段
// 也可以先不赋值
p3 := new(People)
p3.Age = 25
p3.name = "Kaven"


/**
* 方法
*/
// 方法通常是针对一个结构体来说的
type Foo struct {
  a int
}
// 值接收者
func (f Foo) test() {
  f.a = 1 // 不会改变原来的值
}
// 指针接收者
func (f *Foo) test() {
  f.a = 1 // 会改变原值
}


/**
 * 并发 golang 的特别之处
 */
// go 协程
go func() {
  time.Sleep(10 * time.Second)
  println("hello")
}()  // 不会阻塞代码的运行 代码会直接向下运行
// channel 通道
c := make(chan int)
// 两个协程间可以通过chan通信
go func() {c <- 1}()  // 此时c会被阻塞 直到值被取走前都不可在塞入新值
go func() {println(<-c)}()
// 带缓存的channel
bc := make(chan int, 2)
go func() {c <- 1; c <-2}()  // c中可以存储声明时所定义的缓存大小的数据，这里是2个
go func() {println(<-c)}()
