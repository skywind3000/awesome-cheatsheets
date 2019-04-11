Python 速查表中文版
===

- 本手册是 [Python cheat sheet](http://datasciencefree.com/python.pdf) 的中文翻译版。原作者：Arianne Colton and Sean Chen(data.scientist.info@gmail.com)
- 编译：[ucasFL](https://github.com/ucasFL)

## 目录

- [常规](#常规)
- [数值类类型](#数值类类型)
- [数据结构](#数据结构)
- [函数](#函数)
- [控制流](#控制流)
- [面向对象编程](#面向对象编程)
- [常见字符串操作](#常见字符串操作)
- [异常处理](#异常处理)
- [列表、字典以及元组的推导表达式](#列表、字典以及元组的推导表达式)
- [单元测试](#单元测试)

## 常规

- Python 对大小写敏感
- Python 的索引从 0 开始
- Python 使用空白符（制表符或空格）来缩进代码，而不是使用花括号

### 获取帮助

- 获取主页帮助：`help()`
- 获取函数帮助：`help(str.replace)`
- 获取模块帮助：`help(re)`

### 模块(库)

Python的模块只是一个简单地以 `.py` 为后缀的文件。

- 列出模块内容：`dir(module1)`
- 导入模块：`import module`
- 调用模块中的函数：`module1.func1()`

> **注**：`import`语句会创建一个新的命名空间(namespace)，并且在该命名空间内执行`.py`文件中的所有语句。如果你想把模块内容导入到当前命名空间，请使用`from module1 import *`语句。

## 数值类类型

查看变量的数据类型：`type(variable)`

### 六种经常使用的数据类型

1. **int/long**：过大的 `int` 类型会被自动转化为 `long` 类型

2. **float**：64 位，Python 中没有 `double` 类型

3. **bool**：真或假

4. **str**：在 Python 2 中默认以 ASCII 编码，而在 Python 3 中默认以 Unicode 编码

    - 字符串可置于单/双/三引号中
    - 字符串是字符的序列，因此可以像处理其他序列一样处理字符串
    - 特殊字符可通过 `\` 或者前缀 `r` 实现：

        ```python
        str1 = r'this\f?ff'
        ```

    - 字符串可通过多种方式格式化：

        ```python
        template = '%.2f %s haha $%d';
        str1 = template % (4.88, 'hola', 2)
        ```

5. **NoneType(None)**：Python “null”值（`None`对象**只**存在一个实例）

    - `None`不是一个保留关键字，而是`NoneType`的一个唯一实例
    - `None`通常是可选函数参数的默认值：

        ```python
        def func1(a, b, c=None)
        ```

    - `None`的常见用法：

        ```python
        if variable is None :
        ```

6. **datetime**：Python内置的`datetime`模块提供了`datetime`、`data`以及`time`类型。

    - `datetime`组合了存储于`date`和`time`中的信息

    ```python
    # 从字符串中创建 datetime
    dt1 = datetime.strptime('20091031', '%Y%m%d')
    # 获取 date 对象
    dt1.date()
    # 获取 time 对象
    dt1.time()
    # 将 datetime 格式化为字符串
    dt1.strftime('%m/%d/%Y%H:%M')
    # 更改字段值
    dt2 = dt1.replace(minute=0, second=30)
    # 做差, diff 是一个 datetime.timedelta 对象
    diff = dt1 - dt2
    ```

> **注**：
> - `str`、`bool`、`int`和`float`同时也是显式类型转换函数。
> - 除字符串和元组外，Python 中的绝大多数对象都是可变的。

## 数据结构

> **注**：所有的“非只读(non-Get)”函数调用，比如下面例子中的`list1.sort()`，除非特别声明，都是原地操作(不会创建新的对象)。

### 元组

元组是 Python 中任何类型的对象的一个一维、固定长度、**不可变**的序列。

```python
# 创建元组
tup1 = 4, 5, 6
tup1 = (6, 7, 8)
# 创建嵌套元组
tup1 = (4, 5, 6), (7, 8)
# 将序列或迭代器转化为元组
tuple([1, 0, 2])
# 连接元组
tup1 + tup2
# 解包元组
a, b, c = tup1
```

**元组应用**：

```python
# 交换两个变量的值
a, b = b, a
```

### 列表

列表是 Python 中任何类型的对象的一个一维、非固定长度、**可变**（比如内容可以被修改）的序列。

```python
# 创建列表
list1 = [1, 'a', 3]
list1 = list(tup1)
# 连接列表
list1 + list2
list1.extend(list2)
# 追加到列表的末尾
list1.append('b')
# 插入指定位置
list1.insert(PosIndex, 'a')
# 反向插入，即弹出给定位置的值/删除
ValueAtIdx = list1.pop(PosIndex)
# 移除列表中的第一个值, a 必须是列表中第一个值
list1.remove('a')
# 检查成员
3 in list1 => True or False
# 对列表进行排序
list1.sort()
# 按特定方式排序
list1.sort(key=len) # 按长度排序
```

> - 使用 + 连接列表会有比较大的开支，因为这个过程中会创建一个新的列表，然后复制对象。因此，使用`extend()`是更明智的选择。
> - `insert`和`append`相比会有更大的开支（时间/空间）。
> - 在列表中检查是否包含一个值会比在字典和集合中慢很多，因为前者需要进行线性扫描，而后者是基于哈希表的，所以只需要花费常数时间。

#### 内置的`bisect`模块

- 对一个排序好的列表进行二分查找或插入
- `bisect.bisect`找到元素在列表中的位置，`bisect.insort`将元素插入到相应位置。
- 用法：

    ```python
    import bisect
    list1 = list(range(10))
    #找到 5 在 list1 中的位置，从 1 开始，因此 position = index + 1
    bisect.bisect(list1, 5)
    #将 3.5 插入 list1 中合适位置
    bisect.insort(list1, 3.5)
    ```

> **注**：`bisect` 模块中的函数并不会去检查列表是否排序好，因为这会花费很多时间。所以，对未排序好的列表使用这些函数也不会报错，但可能会返回不正确的结果。

### 针对序列类型的切片

> 序列类型包括`str`、`array`、`tuple`、`list`等。

用法：

```python
list1[start:stop]
# 如果使用 step
list1[start:stop:step]
```

> **注**：
> - 切片结果包含 `start` 索引，但不包含 `stop` 索引
> - `start/stop` 索引可以省略，如果省略，则默认为序列从开始到结束，如 `list1 == list1[:]` 。

`step` 的应用：

```python
# 取出奇数位置的元素
list1[::2]
# 反转字符串
str1[::-1]
```

### 字典（哈希表）

```python
# 创建字典
dict1 = {'key1': 'value1', 2: [3, 2]}
# 从序列创建字典
dict(zip(KeyList, ValueList))
# 获取/设置/插入元素
dict1['key1']
dict1['key1'] = 'NewValue'
# get 提供默认值
dict1.get('key1', DefaultValue)
# 检查键是否存在
'key1' in dict1
# 获取键列表
dict1.keys()
# 获取值列表
dict1.values()
# 更新值
dict1.update(dict2)  # dict1 的值被 dict2 替换
```

> - 如果键不存在，则会出现 `KeyError Exception` 。
> - 当键不存在时，如果 `get()`不提供默认值则会返回 `None` 。
> - 以相同的顺序返回键列表和值列表，但顺序不是特定的，也就是说极大可能非排序。

#### 有效字典键类型

- 键必须是不可变的，比如标量类型(`int`、`float`、`string`)或者元组（元组中的所有对象也必须是不可变的）。
- 这儿涉及的技术术语是“可哈希(hashability)”。可以用函数`hash()`来检查一个对象是否是可哈希的，比如 `hash('This is a string')`会返回一个哈希值，而`hash([1,2])`则会报错（不可哈希）。

### 集合

- 一个集合是一些**无序**且唯一的元素的聚集；
- 你可以把它看成只有键的字典；

    ```python
    # 创建集合
    set([3, 6, 3])
    {3, 6, 3}
    # 子集测试
    set1.issubset(set2)
    # 超集测试
    set1.issuperset(set2)
    # 测试两个集合中的元素是否完全相同
    set1 == set2
    ```

- **集合操作**
  - 并（或）：`set1 | set2`
  - 交（与）：`set1 & set2`
  - 差：`set1 - set2`
  - 对称差（异或）：`set1 ^ set2`

## 函数

Python 的函数参数传递是通过**引用传递**。

- 基本形式

    ```python
    def func1(posArg1, keywordArg1=1, ..)
    ```

    > **注**：
    > - 关键字参数必须跟在位置参数的后面；
    > - 默认情况下，Python 不会“延迟求值”，表达式的值会立刻求出来。

- 函数调用机制

    1. 所有函数均位于模块内部作用域。见“模块”部分。
    1. 在调用函数时，参数被打包成一个元组和一个字典，函数接收一个元组`args`和一个字典`kwargs`，然后在函数内部解包。

- “函数是对象”的常见用法：

    ```python
    def func1(ops = [str.strip, user_define_func, ..], ..):
        for function in ops:
            value = function(value)
    ```

### 返回值

- 如果函数直到结束都没有`return`语句，则返回`None`。
- 如果有多个返回值则通过**一个**元组来实现。

    ```python
    return (value1, value2)
    value1, value2 = func1(..)
    ```

### 匿名函数（又称 LAMBDA 函数）

- 什么是匿名函数？

    匿名函数是一个只包含一条语句的简单函数。

    ```python
    lambda x : x * 2
    # def func1(x) : return x * 2
    ```

- 匿名函数的应用：“柯里化(curring)”，即利用已存在函数的部分参数来派生新的函数。

    ```python
    ma60 = lambda x : pd.rolling_mean(x, 60)
    ```

### 一些有用的函数（针对数据结构）

1. **Enumerate** 返回一个序列`(i, value)`元组，`i` 是当前 `item` 的索引。

    ```python
    for i, value in enumerate(collection):
    ```

    - 应用：创建一个序列中值与其在序列中的位置的字典映射（假设每一个值都是唯一的）。

1. **Sorted** 可以从任意序列中返回一个排序好的序列。

    ```python
    sorted([2, 1, 3]) => [1, 2, 3]
    ```

    - 应用：

        ```python
        sorted(set('abc bcd')) => [' ', 'a', 'b', 'c', 'd']
        # 返回一个字符串排序后无重复的字母序列
        ```

1. **Zip** 函数可以把许多列表、元组或其他序列的元素配对起来创建一系列的元组。

    ```python
    zip(seq1, seq2) => [('seq1_1', 'seq2_1'), (..), ..]
    ```

    - `zip()`可以接收任意数量的序列作为参数，但是产生的元素的数目取决于最短的序列。

    - 应用：多个序列同时迭代：

        ```python
        for i, (a, b) in enumerate(zip(seq1, seq2)):
        ```

    - `unzip`：另一种思考方式是把一些行转化为一些列：

        ```python
        seq1, seq2 = unzip(zipOutput)
        ```

1. **Reversed** 将一个序列的元素以逆序迭代。

    ```python
    list(reversed(range(10)))
    ```

    > `reversed()` 会返回一个迭代器，`list()` 使之成为一个列表。

## 控制流

1. 用于 `if-else` 条件中的操作符：

    ```python
    var1 is var2  # 检查两个变量是否是相同的对象

    var1 is not var2  # 检查两个变量是否是不同的对象

    var1 == var2  # 检查两个变量的值是否相等
    ```

    > **注**：Python 中使用 `and`、`or`、`not` 来组合条件，而不是使用 `&&`、`||`、`!` 。

1. `for`循环的常见用法：

    ```python
    for element in iterator:  # 可迭代对象（list、tuple）或迭代器
        pass

    for a, b, c in iterator:  # 如果元素是可以解包的序列
        pass
    ```

1. `pass`：无操作语句，在不需要进行任何操作的块中使用。
1. 三元表达式，又称简洁的 `if-else`，基本形式：

    ```python
    value = true-expr if condition else false-expr
    ```

1. Python 中没有 `switch/case` 语句，请使用 `if/elif`。

## 面向对象编程

1. **对象**是 Python 中所有类型的根。
1. 万物（数字、字符串、函数、类、模块等）皆为对象，每个对象均有一个“类型(type)”。对象变量是一个指向变量在内存中位置的指针。
1. 所有对象均会被**引用计数**。

    ```python
    sys.getrefcount(5) => x
    a = 5, b = a
    # 上式会在等号的右边创建一个对象的引用，因此 a 和 b 均指向 5
    sys.getrefcount(5)
    => x + 2
    del(a); sys.getrefcount(5) => x + 1
    ```

1. 类的基本形式：

    ```python
    class MyObject(object):
        # 'self' 等价于 Java/C++ 中的 'this'
        def __init__(self, name):
            self.name = name
        def memberFunc1(self, arg1):
            pass
        @staticmethod
        def classFunc2(arg1):
            pass
    obj1 = MyObject('name1')
    obj1.memberFunc1('a')
    MyObject.classFunc2('b')
    ```

1. 有用的交互式工具：

    ```python
    dir(variable1)  # 列出对象的所有可用方法
    ```

## 常见字符串操作

```python
# 通过分隔符连接列表/元组
', '.join([ 'v1', 'v2', 'v3']) => 'v1, v2, v3'

# 格式化字符串
string1 = 'My name is {0}　{name}'
newString1 = string1.format('Sean', name =　'Chen')

# 分裂字符串
sep = '-';
stringList1 =　string1.split(sep)

# 获取子串
start = 1;
string1[start:8]

# 补 '0' 向右对齐字符串
month = '5';
month.zfill(2) => '05'
month = '12';
month.zfill(2) => '12'
month.zfill(3) => '012'
```

## 异常处理

1. 基本形式：

    ```python
    try:
        pass
    except ValueError as e:
        print e
    except (TypeError, AnotherError):
        pass
    except:
        pass
    finally:
        pass  # 清理，比如 close db;
    ```

1. 手动引发异常：

    ```python
    raise AssertionError  # 断言失败
    raise SystemExit
    # 请求程序退出
    raise RuntimeError('错误信息 :..')
    ```

## 列表、字典以及元组的推导表达式

使代码更加易读易写的语法糖。

1. **列表推导**

    - 用一个简练的表达式，通过筛选一个数据集并且转换经过筛选的元素的方式来简明地生成新列表。
    - 基本形式：

        ```python
        [expr for val in collection if condition]
        ```

    等价于

    ```python
    result = []
    for val in collection:
        if condition:
            result.append(expr)
    ```

    可以省略过滤条件，只留下表达式。

2. **字典推导**

    - 基本形式：

        ```python
        {key-expr : value-expr for value in collection if condition}
        ```

3. **集合推导**

    - 基本形式：和列表推导一样，不过是用 `()` 而不是 `[]` 。

4. **嵌套列表**

    - 基本形式：

        ```python
        [expr for val in collection for innerVal in val if condition]
        ```

## 单元测试

Python自带`unittest`模块，可供我们编写单元测试。

```python
import unittest
```

我们可以编写继承于`unittest.TestCase`测试类的子类，并在子类中编写具体的测试函数。测试函数命必须以`test_`开头，否则不会被识别为测试函数，进而不会在运行单元测试时被运行。

```python
class TestSubclass(unittest.TestCase):

    def test_func(self):
        self.assertEqual(0, 0)
        # 可以通过msg关键字参数提供测试失败时的提示消息
        self.assertEqual(0, 0, msg='modified message')
        self.assertGreater(1, 0)
        self.assertIn(0, [0])
        self.assertTrue(True)
        # 测试是否会抛出异常
        with self.assertRaises(KeyError):
            _ = dict()[1]

    # 被@unittest.skip装饰器装饰的测试类或测试函数会被跳过
    @unittest.skip(reason='just skip')
    def test_skip(self):
        raise Exception('I shall never be tested')
```

另外，`unittest.TestCase`中还有两个特殊的成员函数，他们分别会在调用每一个测试函数的前后运行。在测试前连接数据库并在测试完成后断开连接是一种常见的使用场景。

```python
def setUp(self):
    # To do: connect to the database
    pass

def tearDown(self):
    # To do: release the connection
    pass

def test_database(self):
    # To do: test the database
    pass
```

测试类编写完毕后，可以通过添加以下代码来将当前文件当成正常的Python脚本使用

```python
if __name__ == '__main__':
  unittest.main()
```
