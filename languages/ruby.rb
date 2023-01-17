# Ruby

收集与翻译均来自reference



## Variables



### 基本变量类型

```ruby
# Nil: 空值 ，例如没有找到定义，下标所指的array对象超出array界限，hash下key不存在
# string ： 字符型
full_name = 'Ruby'
# integer: 整数型
count = 20
# float ： 浮点数型
book_price = 12.3
#Array : 数组型
fruits = ['Appel','Orange','Banana']
#Hash : 哈系类型
fruite_color = {apple:'read'}
# Struct: 结构体
Person = Struct.new(:name,:age)
person1  = Person.new 'mike', 50

```



### 变量赋值

```ruby
# title赋值，默认为”Default title“。如果custom_title不为nil，则title是custom——title
title =  custom_title || 'Default title'
# search为空则将params[:search]赋值给search
search ||= params[:search]

```



### 数组

```ruby
# 数组声明
names = Array.new
names = Array.new(20)
# 直接定义一个数组给变量
fruits = ['Apple', 'Orange', 'Banana']
fruits = %w(Apple Orange Banana) 


# 快速生成数组
(1..10).to_a  # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
('a'..'e').to_a # ['a', 'b', 'c', 'd', 'e']

fruits.length # 3

fruits.first  # Apple
fruits.last   # Banana

fruits[0]     # Apple
fruits[-2]    # Orange
fruits[3]     # nil
fruits[1..2]  # ['Orange', 'Banana']

# 遍历
fruits.each do { |fruit| puts fruit } 

fruits.each_with_index do |fruit, index|
  puts fruit  # Apple
  puts index  # 0
end
```

### Hash

```ruby
product = {}
product['title'] = "Mac Book Pro"
product[:price] = 1599.99
product = { 'title' => 'Mac Book Pro', 'price' => 1599.99 }
product = { title: 'Mac Book Pro', price: 1599.99 }
puts product.fetch(:cost, 0)  # 返回默认值0
product.keys   # [:title, :price]
product.values # ['Mac Book Pro', 1599.99]

product.each do |key, value| 
  puts key
  puts value
end
```





## Function



```ruby
# 基本结构
def func 
    #some code
end
# 带参数的函数
def greeting(name = 'John')  # = default argument value
  "Hello #{name}"  # implicit return
end
puts greeting('Paul')  # Hello Paul

# 可变参数的函数
def greeting(*names)
  names.each { |name| puts name }
end

# 传入指定命名的参数
def display_product(price, options = {})
  puts price, options[:hidden], options[:rounded]
end
display_product 1599, hidden: false, rounded: true
```



## Class&Modules

class

```ruby
class ProductManager
    #some code
end
```

modules

```ruby
# 基础结构
module CUstomerSupport
    #some code
end

# 静态modules方法
module Display
  def self.hello
    puts 'Hello'
  end
end
Display.hello
```

## Control Flow & loop

### 遍历

```ruby
loop do
  puts "Stop loop by using 'break' statement"
  puts "Skip one occurence by using 'next' statement"
end

while number < 100
  puts number
  number += 1
end

# Range
# Range: 遍历表达方式1
(1..10).each { |i| puts i } 
# Range: 便利表达方式2
(1..10).each do |i|  
  puts i
end

# 进行计数范围的函数执行
10.times { puts "Hello World" } # 输出10次Hello World

```

### 条件判断

```ruby
# Equal ==   And &&   Or ||   Not !
if action == 1
  puts "action 1"
elsif action < 5
  puts "action not 1 but less than 5"
else
  puts "action greater than 5"
end

#Unless (if的否定)
puts 'The user is not active' unless active == true

# 三目运算符
active ? 'The user is active' : 'The user is not active'

# case when else
case points
when 0
  "Not good"
when 1..50
  "Better but not great"
when 51..70
  "Thats good!"
when 71..99
  "Great"
when 100
  "Perfect"
else
  "Score error"
```



## Common Methods

### 输出

```ruby
# 带换行
puts 'Hello World'
# 不带换行
print 'Hello World with no line break'

```



### 字符型

```ruby
# 字符串插值（格式化字符串输出用）
name = 'Mike'
message = 'Hello #{name}'

# 获取字符串长度
'This is a string'.length

# 判断字符串是否为空
''.empty? # true


# 字符串字母大写
'hello world'.upcase #HELLO WORLD


# 字符串字母小写
'HI'.downcase #hi


# 首字母大写 剩余消协
'miKE'.capitalize # Mike

# 去除字符串空格
' This is a string with space  '.strip

# 左对齐并且增加字符填充
'hello'.ljust(20, '.')  # 'hello...............'

# 判断是否为子字符串
'hello World'.include? 'World' # true

#获取子字符串的下标
'Welcome to this web site'.index('this') # 11


# 获取字符串指定下标的内容（从0开始）
'This is a string'[1]  # h
'This is a string'[0..3]  # This
'This is a string'[-1]  # g (-1代表最后）

# 替换第一个子字符串
'Hello dog my dog'.sub 'dog', 'cat'. # Hello cat my dog


#字符串转换为array
'Apple Orange Banana'.split ' '  #['Apple', 'Orange', 'Banana']


#获取控制台键盘输入
input = gets


#获取命令行的参数（arguments)，例如 ruby main.rb arg1 arg2
puts ARGV  # ['arg1', 'arg2']

```

### 数字型

```ruby

number.round 2.68  # 3
number.floor 2.68  # 2
number.ceil 2.68   # 3

2.next  # 3

# 随机数字
random_number = rand(1..100)
```

### 数组

```ruby

fruits = ['Apple', 'Orange', 'Banana']

# 数组是否包含
fruits.include? 'Orange'  # true

# 排序：正排和倒排
[1, 5, 2, 4, 3].sort  # [1, 2, 3, 4, 5]
[1, 2, 3].reverse  # [3, 2, 1]

# 增加到数组末尾
fruits.push 'Strawberry' # 方法1
fruits <<  'Raspberry' # 方法2

# 增加元素到数组开头
fruits.unshift 'Strawberry'


# 移除数组最后一个
fruits.pop 
# 移除一个
fruits.delete_at(0) # 方法1 
fruits.shift # 方法2


# array转string
fruits.join ', '  # 'apple, orange, banana'


# 两个数组合并 - 合并赋值给新数组
array1 = %w(dog cat bird)
array2 = %w(fish hamster)
array3 = array1 + array2 #['dog', 'cat', 'bird', 'fish', 'hamster']


# 两个数组合并到原有数组基础上
array1.concat array2 
puts array1  #['dog', 'cat', 'bird', 'fish', 'hamster']



# 使用*表达式来构造数组
puts ['dog', *array2, 'bird']  #['dog', 'fish', 'hamster', bird']
```

### 类型转换

```ruby

123.to_s   # convert number to string "123"
"123".to_i # convert string to integer 123
"123".to_f # convert string to float 123.0


#字符串转换为array（上面的例子）
'Apple Orange Banana'.split ' '  #['Apple', 'Orange', 'Banana']
# array转string （上面的例子）
fruits.join ', '  
```

### 日期和时间

```ruby
Time.now.utc    # 2020-12-13 03:17:05 UTC
Time.now.to_i   # Timestamp 1607829496

christmas = Time.new(2020, 12, 25)  #
puts christmas.wday # return 5 (Thursday)

now = Time.now  # current time: 2020-12-13 03:08:15 +0000
now.year    # 2020
now.month   # 12
now.day     # 13
now.hour    # 3
now.min     # 8
now.sec     # 15
now.sunday? # true

past = Time.now - 20  # 返回当前时间减去20秒
past_day = Time.now - 86400 # 60 secs * 60 mins * 24 hours
past_day = Time.now - 1.day # 仅在Rail生效

time = Time.new
time.strftime("%d of %B, %Y")   # 格式化输出： "25 of December, 2020"
```

### 正则表达式

```ruby
zip_code = /\d{5}/
"Hello".match zip_code  # nil
"White House zip: 20500".match zip_code  # 20500
"White House: 20500 and Air Force: 20330".scan zip_code # ['20500', '20330'] 
"Apple Orange Banana".split(/\s+/) # ['Apple','Orange', 'Banana']
```

### I/O

文件

```ruby
# 读文件
text = File.read('exemple.txt')

# 按行读取文件
lines = File.readlines("exemple.txt")
lines.each do |line|
  puts "Line: #{line}"
end

# 写文件
File.write('exemple.txt', 'text to write...')

File.open(“index.html”, “w”) do | file | 
  file.puts ‘text to write’ 
end


# 读取csv
require 'csv'
table = CSV.parse(File.read("products.csv"), headers: true)
table[0]["id"] # 1000
table[0]["name"] # "Mac Book Pro"

# 写csv
products = [
  { name: "Mac Book Pro", price: 1599 },
  { name: "IPad Pro", price: 799 }
]
CSV.open("products.csv", "w", headers: products.first.keys) do |csv|
  products.each { |product| csv << product.values }
end
```



## Errors/Exceptions Handling

```ruby
# 引发（raise）一个异常 并输出异常消息
raise "This is an exception"


```



## Other Tips

- `irb` 进入交互式ruby（interactive Ruby)模式中

## Reference

- https://dev.to/ericchapman/my-beloved-ruby-cheat-sheet-208o
