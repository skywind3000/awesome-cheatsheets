 --------------------------------------------------------------------------------
 -- Lua CHEATSHEET (中文速查表)  -  by weizhixiangcoder (created on 2020/06/20)
 -- Version: 1
 -- https://github.com/skywind3000/awesome-cheatsheets
 --------------------------------------------------------------------------------
 

---------------------------------------------------------------------------------
--[[
	Lua 特性：
		轻量级：源码2.5万行左右C代码， 方便嵌入进宿主语言(C/C++)
		可扩展：提供了易于使用的扩展接口和机制， 使用宿主语言提供的功能
		高效性：运行最快的脚本语言之一
		可移植：跨平台
	入门书籍《lua程序设计》
		推荐：云风翻译的《Lua 5.3参考手册》	
		http://cloudwu.github.io/lua53doc/manual.html
	源码： 
		http://www.lua.org/ftp/
--]]
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--[[
	变量: 作为动态类型语言，变量本身没有类型， 赋值决定某一时刻变量的类型。私有静态
	变量带local, 公有静态变量不带local。
		数据类型：
			nil            	为空，无效值，在条件判断中表示false
			boolean			包含两个值：false和true
			number			表示双精度类型的实浮点数
			string			字符串由一对双引号或单引号来表示
			function		由 C 或 Lua 编写的函数
			table			Lua 中的表（table）其实是一个"关联数组"（associative
							arrays），数组的索引可以是数字、字符串或表类型
			thread			协程
			userdata		存储在变量中的C数据结构
--]]
---------------------------------------------------------------------------------
print(type(signal))						--nil

signal = true				
print(type(signal))						--boolean

signal = 1454
print(type(signal))						--number

signal = "UnionTech"
print(type(signal))						--string			

signal = function() 
	print(type(signal))
end 	
print(type(signal))						--function

signal = {}								
print(type(signal))						--table

signal = coroutine.create(function()
	print(type(signal))
end)
print(type(signal))						--coroutine



---------------------------------------------------------------------------------
--[[
	流程控制：if...elseif...else、 while、 for
--]]
---------------------------------------------------------------------------------
--if...else
ty_signal = type(signal)
if ty_signal == "coroutine" then
    print("signal type is coroutine")
elseif ty_signal == "table" then
    print("signal type is table")
else
    print("signal type is other")
end

--while
ut_companys = {"beijing company", "shanghai company", "nanjing company", "wuxi company", "guangzhou company", "yunfu company", "wuhan company", "chengdu company", "xian company"}
count = 0
while count <= #ut_companys 
do
    count = count + 1
    print("ut_companys[", count, "] is ", ut_companys[count])
end

--for
for i=#ut_companys, 1, -2 do        --以2为步长反向遍历
    print("num: ", i, "company: ", ut_companys[i])
end


---------------------------------------------------------------------------------
--[[
	table： 表作为Lua唯一自带的数据结构， 使用简单方便， 兼具数组和Map作为容器的
	功能，通过表可以很容易组成常见的数据结构， 如栈、队列、链表、集合，用for循环
	很容易迭代遍历表数据。
--]]
---------------------------------------------------------------------------------
--table当数组用，下标从1开始
for i, c in ipairs(ut_companys) do
	print(string.format("1 UnionTech company: %d		%s", i, c))
end

table.sort(ut_companys)
for i=#ut_companys, 1, -1 do
	print(string.format("2 UnionTech company: %d		%s", i, ut_companys[i]))
end

--table当hash map用
ut_cptypes = {}

ut_cptypes["adapter"] = {"beijing company", "wuhan company", "guangzhou company"}
ut_cptypes["developer"] = {"beijing company", "wuhan company", "nanjing company", "chengdu company", "xian company", "guangzhou company"}
ut_cptypes["general"] = {"beijing company"}

for ty, cps in pairs(ut_cptypes) do
	for i, cp in ipairs(cps) do
		print(string.format("3 UnionTech companys: type:%s  identifier:%s	company:%s", ty, i, cp))
	end
end


---------------------------------------------------------------------------------
--[[
	函数：在Lua中函数也是第一类型值， 可赋值给变量， 也可以在函数体内定义并使用函数，或者
	是直接使用匿名匿名函数。
--]]
---------------------------------------------------------------------------------
--多重返回值
ut_types = {"adapter", "developer", "general"}
function company_types(cp, cptypes)
	local adpt, dvlp, genl = nil, nil, nil
	for i, ty in ipairs(ut_types) do
		for _, _cp in ipairs(cptypes[ty]) do
			if _cp == cp then
				if i == 1 then
					adpt = true
				elseif i == 2 then
					dvlp = true
				elseif i == 3 then
					genl = true
				end
				break
			end
		end
	end
	return adpt, dvlp, genl
end

cp = "wuhan company"
types = {company_types(cp, ut_cptypes)}

for i, ty in ipairs(types) do
	if ty then
		print(string.format("%s  is %s", cp, ut_types[i]))
	end
end 

--变参
function printf(str, ...)
	print(string.format(str, ...))
end

function add_companys(...)
	local newcps = {...}
	local num = #newcps
	for _, cp in ipairs(newcps) do
		table.insert(ut_companys, cp)
	end
	return ut_companys, num
end

_, _ = add_companys("changsha company", "zhengzhou company", "hefei company")
for i=1, #ut_companys do
	--print(string.format("4 UnionTech company: %d		%s", i, ut_companys[i]))
	printf("4 UnionTech company: %d		%s", i, ut_companys[i])
end

--闭包
function all_companys(cps)
	local companys, n = {}, 0
	for _, v in ipairs(cps) do
		table.insert(companys, v)
	end
	return function()
		n = n + 1
		if n > #companys then
			return ""
		else
			return companys[n]
		end
	end
end

get_company = all_companys(ut_companys)
while true
do
	cp = get_company()
	if cp == "" then
		break
	else	
		printf("get company: %s", cp)
	end
end


---------------------------------------------------------------------------------
--[[
	协程(coroutine)：Lua协同程序(coroutine)与线程比较类似：拥有独立的堆栈，独立的局
	部变量，独立的指令指针，同时又与其它协同程序共享全局变量和其它大部分东西。
--]]
---------------------------------------------------------------------------------
function foo (a)
    print("foo 函数输出", a)
    return coroutine.yield(2 * a) -- 返回  2*a 的值
end
 
co = coroutine.create(function (a , b)
    print("第一次协同程序执行输出", a, b) -- co-body 1 10
    local r = foo(a + 1)
     
    print("第二次协同程序执行输出", r)
    local r, s = coroutine.yield(a + b, a - b)  -- a，b的值为第一次调用协同程序时传入
     
    print("第三次协同程序执行输出", r, s)
    return b, "结束协同程序"                   -- b的值为第二次调用协同程序时传入
end)
       
print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
--resume将主协程数据传入次协程， yield将次协程中数据传回主协程


---------------------------------------------------------------------------------
--[[
	元表(Metatable)：本质上来说就是存放元方法的表结构， 通过元表实现对表中数据和行为
	的改变。
	Lua 查找一个表元素时的规则，其实就是如下 3 个步骤:
		1.在表中查找，如果找到，返回该元素，找不到则继续
		2.判断该表是否有元表，如果没有元表，返回 nil，有元表则继续。
		3.判断元表有没有 __index 方法，如果 __index 方法为 nil，则返回 nil；如果
		__index 方法是一个表，则重复 1、2、3；如果 __index 方法是一个函数，则返
		回该函数的返回值
	
--]]
---------------------------------------------------------------------------------
father = {
	colourofskin = "yellow",
	weight = 70,
	work = "programming",
	otherwork = function() 
		print "do housework"
	end
}
father.__index = father

son = {
	weight = 50,
	like = "basketball"
}

setmetatable(son, father)
printf("weight:%d 	like:%s  	work:%s		colourofskin:%s ", son.weight, son.like, son.work, son.colourofskin)
son.otherwork()


---------------------------------------------------------------------------------
--[[
    面向对象：因为lua本身不是面向对象的语言， 在lua中， 通过table和function来模拟一个对象， 
    用metatable来模拟面向对象中的继承，但是在使用的时候需要考虑lua作为脚本语言， 变量的类型随
    所赋值类型而改变。
--]]
---------------------------------------------------------------------------------
--父类
rect = {
    area = 0,
    length = 0, 
    width = 0,
}

function rect:getArea()
    if self.area == 0 then
        self.area = self.length * self.width
    end
    
    return self.area
end

function rect:getLength()
    return self.length
end

function rect:new(leng, wid)
    self.length = leng
    self.width = wid
    return self    
end

--子类
cuboid = {
    volume = 0,
    height = 0,
}

function cuboid:getVolume()
    if self.volume == 0 then
        self.volume = self.height * self:getArea()
    end
    return self.volume
end

function cuboid:new(_rect, _height)
    setmetatable(self, _rect)
    _rect.__index = _rect
    self.height = _height
    return self
end

rect1 = rect:new(5, 10)
print("rect1 rectangle:", rect1:getArea())

cuboid1 = cuboid:new(rect1, 2)
print("cuboid1 volume: ", cuboid1:getVolume())
print("cuboid1 rectangle: ", cuboid1:getArea())             --子类调用父类方法getArea
print("cuboid1 length function: ", cuboid1:getLength())     --子类调用父类方法getLength
print("cuboid1 length variable: ", cuboid1.length)          --子类使用父类变量length

--重写子类接口getArea， lua中没有重载
function cuboid:getArea()                                   
    return 2 * (self.height * self.length + self.height * self.width + self.length * self.width)
end

cuboid2 = cuboid:new(rect1, 2)
print("cuboid2 function: getArea: ", cuboid2:getArea())                     --调用子类重写的方法getArea
print("cuboid2 base function: getArea: ", getmetatable(cuboid2):getArea())  --显示调用父类方法getArea


---------------------------------------------------------------------------------
--[[
	模块与C包: 模块类似封装库， 有利于代码复用， 降低耦合， 提供被调用的API。
	----------------------------------------------------------------------
	-- 文件名为 module.lua, 定义一个名为 module 的模块
	module = {}
	module.constant = "这是一个常量"
	function module.func1()
		io.write("这是一个公有函数！\n")
	end
	
	local function func2()
		print("这是一个私有函数！")
	end
	
	function module.func3()
		func2()
	end
 
	return module
	
	在其他模块中调用module模块：
	local m = require("module")
	print(m.constant)
	----------------------------------------------------------------------
	与Lua中写包不同，C包在使用以前必须首先加载并连接，在大多数系统中最容易的实现方式
	是通过动态连接库机制。Lua在一个叫loadlib的函数内提供了所有的动态连接的功能。
	
	----------------------------------------------------------------------
--]]
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--[[
	lua标准库： 标准库中接口可直接使用不需要require
	常用标准库：
		math		数学计算
		table		表结构数据处理
		string		字符串处理
		os			系统库函数
		io			文件读写
		coroutine	协程库
		debug		调式器
--]]
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--[[
	lua虚拟机：脚本语言没有像编译型语言那样直接编译为机器能识别的机器代码，这意味着
	解释性脚本语言与编译型语言的区别：由于每个脚本语言都有自己的一套字节码，与具体的
	硬件平台无关，所以无需修改脚本代码，就能运行在各个平台上。硬件、软件平台的差异都
	由语言自身的虚拟机解决。由于脚本语言的字节码需要由虚拟机执行，而不像机器代码那样
	能够直接执行，所以运行速度比编译型语言差不少。有了虚拟机这个中间层，同样的代码可
	以不经修改就运行在不同的操作系统、硬件平台上。Java、Python都是基于虚拟机的编程语
	言，Lua同样也是这样。


--]]
---------------------------------------------------------------------------------




--可在命令行lua lua.lua运行本脚本
