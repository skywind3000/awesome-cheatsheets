# C++ Cheatsheet

作者: Joxos(xujunhao61@163.com)

参考：C++ Primer Plus

## 目录

1. 头文件
2. 指针
3. 说明符和限定符
4. 变量
5. 结构
6. 别名
7. 函数


## 头文件
头文件应包含内容：
- 函数原型
- const或#define定义的常量
- 结构声明
- 类声明
- 模板声明
- 内联函数

## 指针

- **空指针声明时指向`nullptr`关键字。**（C++11）

- **用完后必须`delete`指针。**

- 动态联编（分配）的new和delete：

- - *type*\* *pt_name* = new *type* [*number*];
  - delete [] *pt_name*;

- 声明时类型前指针`const`表示不可以通过指针修改指向的值。

- 声明时类型后指针`const`表示不可以指向其他对象。

## 说明符和限定符

- mutable：用于结构或类，指出即使对象为const，**其成员**也可以变动
- volatile：不可以直接修改，但**允许自己变动**，如**硬件对象**

## 变量

### 特殊类型

- **wcha_t：**用wcha_t来表示无法用一个8位的字节表示的字符，用wcout和wcin进行输出和输入。
- **char16_t：**如果一个字符集甚至无法用wcha_t来表示，则可以用char16_t类型。
- **char32_t：**如果一个字符集甚至无法用char16_t来表示，则可以用char32_t类型。
- **bool：**bool类型的变量储存True或False。如果赋值为0，则为False，否则为True。

### 前缀

- F：wchar_t
- u：char16_t类型
- U：char32_t类型
- R"(：原始字符串前缀

### 后缀

- E/e：double浮点
- F/f：float浮点
- L/l：long double浮点
- )"：原始字符串后缀

## 结构

**如果没有初始化，各个成员都将被设为0。**

## 别名

typedef *typeName* *aliasName*

## 函数

- 调用函数的步骤：

- - 拷贝参数，内存中跳转到当前函数的机器码内，复制参数， 运行代码。
  - 将函数的返回值放在CPU寄存器或某个内存地址中。
  - 回到被调用的代码处，取出返回值。

- 为了更高的效率可以把一些十分常用的短小的函数内联起来。

- - 内联一个函数时只要在函数头/定义前面加上inline关键字。
  - 对于内联函数，往往省略函数原型，把主体放在函数原型的地方。

- 函数引用实参时的临时变量创建法则：

- - 实参类型正确，但不是左值（可被引用的数据对象，如变量，结构成员）。
  - 实参类型不正确，但是可被转化成正确的类型。
  - 满足以上任意一点，函数创建临时变量，不操作实参。

- 模板函数的显示具体化：

- - templete <> *return_type* *funcName*<*the_type_to_execute_this_function*>(...) { ... }
  - templete <> *return_type* *funcName*(...) { ... } // If the arguments can let compiler know