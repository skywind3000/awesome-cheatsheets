# VimScript 速查表

译注：折腾 Vim 当然要能看懂和改写相关脚本，而中文资料匮乏，缺一个提纲挈领的教程。本文翻译自 Andrew Scala 的 《[Five Minute Vimscript](http://andrewscala.com/vimscript/)》，立足于让你用最短的时间掌握 VimScript 的基础和要点，你可以把它看成一份语言速查表。

Vim有着丰富的内建文档系统，使用 `:h <关键词>` 就可以阅读，如果你想在方便的尝试各种 vimscript ，你可以通过 NORMAL 模式下使用 `gQ` 命令进入 VimScript 的交互式环境调试命令。

注意：下面的例子中会包含一些形如 `<符号>` 的符号，意味着正式使用时应该被完全替换成真实的东西，包括左右两边的尖括号。而单独的 `<` 和 `>` 在 VimScript 中被用作比较符号。

## 变量

- `let` 命令用来对变量进行初始化或者赋值。
- `unlet` 命令用来删除一个变量。
- `unlet!` 命令同样可以用来删除变量，但是会忽略诸如变量不存在的错误提示。

默认情况下，如果一个变量在函数体以外初始化的，那么它的作用域是全局变量；而如果它是在函数体以内初始化的，那它的作用于是局部变量。同时你可以通过变量名称前加冒号前缀明确的指明变量的作用域：

```text
g:var - 全局
a:var - 函数参数
l:var - 函数局部变量
b:var - buffer 局部变量
w:var - window 局部变量
t:var - tab 局部变量
s:var - 当前脚本内可见的局部变量
v:var - Vim 预定义的内部变量
```

你可以通过 $name 的模式读取或者改写环境变量，同时可以用 &option 的方式来读写 vim 内部的设置值。


## 数据类型

**Number**：32 位有符号整数

```VimL
-123
0x10
0177
```

**Float**: 浮点数，需要编译 Vim 的时候，有 `+float` 特性支持

```VimL
123.456
1.15e-6
-1.1e3
```

**String**: NULL 结尾的 8位无符号字符串

```VimL
"ab\txx\"--"
'x-z''a,c'
```

**Funcref**: 函数引用，函数引用类型的变量名必须以大写字母开头

```VimL
:let Myfunc = function("strlen")
:echo Myfunc('foobar') " Call strlen on 'foobar'.
6
```

**List**: 有序列表

```VimL
:let mylist = [1, 2, ['a', 'b']]
:echo mylist[0]
1
:echo mylist[2][0]
a
:echo mylist[-2]
2
:echo mylist[999]
E684: list index out of range: 999
:echo get(mylist, 999, "THERE IS NO 1000th ELEMENT")
THERE IS NO 1000th ELEMENT
```

**Dictionary**: 无序的 Key/Value 容器

```VimL
:let mydict = {'blue': "#0000ff", 'foo': {999: "baz"}}
:echo mydict["blue"]
#0000ff
:echo mydict.foo
{999: "baz"}
:echo mydict.foo.999
baz
:let mydict.blue = "BLUE"
:echo mydict.blue
BLUE
```

没有布尔类型，整数 0 被当作假，其他被当作真。字符串在比较真假前会被转换成整数，大部分字符串都会被转化为 0，除非以非零开头的字符串才会转化成非零。

（译注：可以调用 type(varname) 来取得变量的类型，最新版 Vim 8.1 中已经包含 Boolean 类型，并且有 v:true, v:false  两个值）

VimScript 的变量属于动态弱类型。

```VimL
:echo 1 . "foo"
1foo
:echo 1 + "1"
2

:function! TrueFalse(arg)
:   return a:arg? "true" : "false"
:endfunction

:echo TrueFalse("foobar")
false
:echo TrueFalse("1000")
true
:echo TrueFalse("x1000")
false
:echo TrueFalse("1000x")
true
:echo TrueFalse("0")
false
```

## 字符串比较

- `<string>` == `<string>`: 字符串相等
- `<string>` != `<string>`: 字符串不等
- `<string>` =~ `<pattern>`: 匹配 pattern
- `<string>` !~ `<pattern>`: 不匹配 pattern
- `<operator>#`: 匹配大小写
- `<operator>?`: 不匹配大小写

注意：设置选项 `ignorecase` 会影响 == 和 != 的默认比较结果，可以在比较符号添加 ? 或者 # 来明确指定大小写是否忽略。


`<string>` . `<string>`: 字符串链接

```VimL
:function! TrueFalse(arg)
:   return a:arg? "true" : "false"
:endfunction

:echo TrueFalse("X start" =~ 'X$')
false
:echo TrueFalse("end X" =~ 'X$')
true
:echo TrueFalse("end x" =~# 'X$')
false
```

## If, For, While, and Try/Catch

条件判断：

```VimL
if <expression>
    ...
elseif <expression>
    ...
else
    ...
endif
```

循环：

```VimL
for <var> in <list>
    continue
    break
endfor
```

复杂循环：

```VimL
for [var1, var2] in [[1, 2], [3, 4]]
    " on 1st loop, var1 = 1 and var2 = 2
    " on 2nd loop, var1 = 3 and var2 = 4
endfor
```

While 循环：

```VimL
while <expression>
endwhile
```

异常捕获：

```VimL
try
    ...
catch <pattern (optional)>
    " HIGHLY recommended to catch specific error.
finally
    ...
endtry
```

## 函数

使用 `function` 关键字定义一个函数，使用 `function!` 覆盖一个函数的定义，函数和变量一样也有作用范围的约束。需要注意函数名必须以大写字母开头。

```VimL
function! <Name>(arg1, arg2, etc)
    <function body>
endfunction
```

`delfunction <function>` 删除一个函数

`call <function>` 调用一个函数，函数调用前的 call 语句是必须的，除非在一个表达式里。

例如：强制创建一个全局函数（使用感叹号），参数使用 `...` 这种不定长的参数形式时，a:1 表示 `...` 部分的第一个参数，a:2 表示第二个，如此类推，a:0 用来表示 `...` 部分一共有多少个参数。

```VimL
function! g:Foobar(arg1, arg2, ...)
    let first_argument = a:arg1
    let index = 1
    let variable_arg_1 = a:{index} " same as a:1
    return variable_arg_1
endfunction
```

有一种特殊的调用函数的方式，可以指明该函数作用的文本区域是从当前缓冲区的第几行到第几行，按照 `1,3call Foobar()` 的格式调用一个函数的话，该函数会在当前文件的第一行到第三行每一行执行一遍，再这个例子中，该函数总共被执行了三次。

如果你在函数声明的参数列表后添加一个 `range` 关键字，那函数就只会被调用一次，这时两个名为 `a:firstline` 和 `a:lastline` 的特殊变量可以用在该函数内部使用。

例如：强制创建一个名为 `RangeSize` 的函数，用来显示被调用时候的文本范围：

```VimL
function! b:RangeSize() range
    echo a:lastline - a:firstline
endfunction
```

## 面向对象

Vim 没有原生的类的支持，但是你可以用字典模拟基本的类。为了定义一个类的方法，可以在函数声明时使用 `dict` 关键字来将内部字典暴露为 `self` 关键字：

```VimL
let MyClass = {"foo": "Foo"}
function MyClass.printFoo() dict
    echo self.foo
endfunction
```

类的实现更类似于 singleton，为了在 VimScript 中创建类的实例，我们对字典使用 `deepcopy()` 方法进行拷贝：

```VimL
:let myinstance = deepcopy(MyClass)
:call myinstance.printFoo()
Foo
:let myinstance.foo = "Bar"
:call myinstance.printFoo()
Bar
```

## 接下来做什么？

现在既然你已经知道了大致原理，下面给你推荐一些好的资源

教程:

- [Vim 中文帮助文档（usr_41） - 编写 Vim 脚本和 API 列表](http://vimcdoc.sourceforge.net/doc/usr_41.html)
- [Vim 脚本指北](https://github.com/lymslive/vimllearn)
- [Vim 脚本开发规范](https://github.com/vim-china/vim-script-style-guide)

其他:

- [知乎：Vim 专栏](https://zhuanlan.zhihu.com/vimrc)


## 感谢

希望你觉得本文对你有用，感谢阅读。
