JavaScript速查表
===
- 本手册绝大部分内容是从Airbnb JavaScript Style Guide精简整理，将开发者们都明确的操作去掉，目的为了就是更快的速查。
  此处为[源地址](https://github.com/airbnb/javascript)。

- 译制：[HaleNing](https://github.com/HaleNing)



## 目录
  - [基础知识](#基础知识)
    - [类型](#类型)
    - [引用](#引用)
    - [对象](#对象)
    - [数组](#数组)
    - [解构](#解构)
    - [字符串](#字符串)
    - [变量](#变量)
    - [属性](#属性)
    - [测试](#测试)
  - [公共约束](#公共约束)
    - [注释](#注释)
    - [分号](#分号)
    - [命名规范](#命名规范)
    - [标准库](#标准库)
  - [类与函数](#类与函数)
    - [函数](#函数)
    - [箭头函数](#箭头函数)
    - [类与构造函数](#类与构造函数)
    - [模块](#模块)
    - [迭代器与生成器](#迭代器与生成器)
    - [提升](#提升)
    - [比较运算符与相等](#比较运算符与相等)
    - [事件](#事件)
    - [类型转换与强制转换](#类型转换与强制转换)
  - [推荐资源](#推荐资源)




## 基础知识


### 类型

- 基本类型
  **最新的 ECMAScript 标准定义了 8 种数据类型,分别是**
  - `string`
  - `number`
  - `bigint`
  - `boolean`
  - `null`
  - `undefined`
  - `symbol` (ECMAScript 2016新增)
> 所有基本类型的值都是不可改变的。但需要注意的是，基本类型本身和一个赋值为基本类型的变量的区别。变量会被赋予一个新值，而原值不能像数组、对象以及函数那样被改变。
- 引用类型
  - `Object`（包含普通对象-Object，数组对象-Array，正则对象-RegExp，日期对象-Date，数学函数-Math，函数对象-Function）

```javascript
使用 typeof 运算符检查：

undefined：typeof instance === "undefined"
Boolean：typeof instance === "boolean"
Number：typeof instance === "number"
String：typeof instance === "string
BigInt：typeof instance === "bigint"
Symbol ：typeof instance === "symbol"
null：typeof instance === "object"。
Object：typeof instance === "object"
```



### 引用

推荐常量赋值都使用`const`, 值可能会发生改变的变量赋值都使用 `let`。

> 为什么？`let`   `const` 都是块级作用域，而 `var`是函数级作用域

```javascript

// bad
var count = 1;
if (true) {
  count += 1;
}

// good, use the let and const 
let count = 1;
const pi =3.14;
if (true) {
  count += 1;
}
```



### 对象

- 使用字面语法创建对象：

  ```javascript
  // bad
  const item = new Object();
  
  // good
  const item = {};
  ```

  

- 在创建具有动态属性名称的对象时使用属性名称:

  ```javascript
  
  function getKey(k) {
    return `a key named ${k}`;
  }
  
  // bad
  const obj = {
    id: 5,
    name: 'San Francisco',
  };
  obj[getKey('enabled')] = true;
  
  // good
  const obj = {
    id: 5,
    name: 'San Francisco',
    [getKey('enabled')]: true,
  };
  ```

  

- 属性值简写，并且推荐将缩写 写在前面 :

  ```javascript
  const lukeSkywalker = 'Luke Skywalker';
  //常量名就是你想设置的属性名
  // bad
  const obj = {
    lukeSkywalker: lukeSkywalker,
  };
  
  // good
  const obj = {
    lukeSkywalker,
  };
  
  const anakinSkywalker = 'Anakin Skywalker';
  const lukeSkywalker = 'Luke Skywalker';
  
  // good
  const obj = {
    lukeSkywalker,
    anakinSkywalker,
    episodeOne: 1,
    twoJediWalkIntoACantina: 2,
    episodeThree: 3,
    mayTheFourth: 4,
  };
  ```

  

- 不要直接调用 `Object.prototype`上的方法，如 `hasOwnProperty`、`propertyIsEnumerable`、`isPrototypeOf`

  > 为什么？在一些有问题的对象上，这些方法可能会被屏蔽掉，如：`{ hasOwnProperty: false }` 或空对象 `Object.create(null)`

  ```javascript
  // bad
  console.log(object.hasOwnProperty(key));
  
  // good
  console.log(Object.prototype.hasOwnProperty.call(object, key));
  
  // best
  const has = Object.prototype.hasOwnProperty; 
  console.log(has.call(object, key));
  /* or */
  import has from 'has'; // https://www.npmjs.com/package/has
  console.log(has(object, key));
  ```

  

- 对象拷贝时，推荐使用`...`运算符来代替`Object.assign`, 获取大对象的多个属性时，也推荐使用`...`运算符

  ```javascript
  // very bad, 因为line2的操作更改了original
  const original = { a: 1, b: 2 };
  const copy = Object.assign(original, { c: 3 }); 
  // 将不需要的属性删除了
  delete copy.a; 
  
  // bad
  const original = { a: 1, b: 2 };
  const copy = Object.assign({}, original, { c: 3 }); // copy => { a: 1, b: 2, c: 3 }
  
  // good 使用 es6 扩展运算符 ...
  const original = { a: 1, b: 2 };
  // 浅拷贝
  const copy = { ...original, c: 3 }; // copy => { a: 1, b: 2, c: 3 }
  
  // rest 解构运算符
  const { a, ...noA } = copy; // noA => { b: 2, c: 3 }
  ```

  



### 数组

- 用扩展运算符做数组浅拷贝，类似上面的对象浅拷贝：

  ```javascript
  // bad
  const len = items.length;
  const itemsCopy = [];
  let i;
  
  for (i = 0; i < len; i += 1) {
    itemsCopy[i] = items[i];
  }
  
  // good
  const itemsCopy = [...items];
  ```

- 用 `...` 运算符而不是 [`Array.from`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/from) 来将一个可迭代的对象转换成数组:

  ```javascript
  const foo = document.querySelectorAll('.foo');
  
  // good
  const nodes = Array.from(foo);
  
  // best
  const nodes = [...foo];
  ```

  

- 使用 [`Array.from`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/from) 而不是 `...` 运算符去做 map 遍历。 因为这样可以避免创建一个临时数组：

  ```javascript
  // bad
  const baz = [...foo].map(bar);
  
  // good
  const baz = Array.from(foo, bar);
  ```

  

- 如果一个数组有很多行，在数组的 `[` 后和 `]` 前断行 :

  ```javascript
  
  // good
  const arr = [[0, 1], [2, 3], [4, 5]];
  
  const objectInArray = [
    {
      id: 1,
    },
    {
      id: 2,
    },
  ];
  
  const numberInArray = [
    1,
    2,
  ];
  ```

  

### 解构

- 用对象的解构赋值来获取和使用对象某个或多个属性值:

  ```javascript
  // bad
  function getFullName(user) {
    const firstName = user.firstName;
    const lastName = user.lastName;
  
    return `${firstName} ${lastName}`;
  }
  
  // good
  function getFullName(user) {
    const { firstName, lastName } = user;
    return `${firstName} ${lastName}`;
  }
  
  // best
  function getFullName({ firstName, lastName }) {
    return `${firstName} ${lastName}`;
  }
  ```

  

- 数组解构:

  ```javascript
  const arr = [1, 2, 3, 4];
  
  // bad
  const first = arr[0];
  const second = arr[1];
  const four = arr[3];
  
  // good
  const [first, second, _,four] = arr;
  ```

  

- 多个返回值用对象的解构，而不是数组解构:

  ```javascript
  // bad
  function processInput(input) {
    return [left, right, top, bottom];
  }
  
  // 数组解构，必须明确前后顺序
  const [left, __, top] = processInput(input);
  
  // good
  function processInput(input) {
    return { left, right, top, bottom };
  }
  // 只需要关注值，而不用关注顺序
  const { left, top } = processInput(input);
  ```

  



### 字符串

- 当需要动态生成字符串时，使用模板字符串而不是字符串拼接：

  ```javascript
  // bad
  function sayHi(name) {
    return 'How are you, ' + name + '?';
  }
  
  // bad
  function sayHi(name) {
    return ['How are you, ', name, '?'].join();
  }
  
  
  // good 可读性比上面更强
  function sayHi(name) {
    return `How are you, ${name}?`;
  }
  ```

  

- 永远不要使用 `eval()`，该方法有太多漏洞。


### 变量

-  不要使用链式变量赋值

> 因为会产生隐式的全局变量

```javascript
// bad
(function example() {
  // JavaScript interprets this as
  // let a = ( b = ( c = 1 ) );
  // The let keyword only applies to variable a; variables b and c become
  // global variables.
  let a = b = c = 1;
}());

console.log(a); // throws ReferenceError
// 在块的外层也访问到了，代表这是一个全局变量。
console.log(b); // 1 
console.log(c); // 1

// good
(function example() {
  let a = 1;
  let b = a;
  let c = a;
}());

console.log(a); // throws ReferenceError
console.log(b); // throws ReferenceError
console.log(c); // throws ReferenceError

// the same applies for `const`
```



- 不要使用一元自增自减运算符（`++`， `--`）

  > 根据 eslint 文档，一元增量和减量语句受到自动分号插入的影响，并且可能会导致应用程序中的值递增或递减的静默错误。 使用 `num + = 1` 而不是 `num ++` 或 `num ++` 语句也是含义清晰的。

```javascript
  // bad

  const array = [1, 2, 3];
  let num = 1;
  num++;
  --num;

  let sum = 0;
  let truthyCount = 0;
  for (let i = 0; i < array.length; i++) {
    let value = array[i];
    sum += value;
    if (value) {
      truthyCount++;
    }
  }

  // good

  const array = [1, 2, 3];
  let num = 1;
  num += 1;
  num -= 1;

  const sum = array.reduce((a, b) => a + b, 0);
  const truthyCount = array.filter(Boolean).length;

```


### 属性

- 访问属性时使用点符号

```javascript
const luke = {
  jedi: true,
  age: 28,
};

// bad
const isJedi = luke['jedi'];

// good
const isJedi = luke.jedi;
```

- 根据表达式访问属性时使用`[]`

```javascript
const luke = {
  jedi: true,
  age: 28,
};

function getProp(prop) {
  return luke[prop];
}

const isJedi = getProp('je'+'di');
```



### 测试

- 无论用哪个测试框架，都需要写测试。
- 尽量去写很多小而美的函数，减少突变的发生
- 小心 stub 和 mock —— 这会让你的测试变得容易出现问题。
- 100% 测试覆盖率是我们努力的目标，即便实际上很少达到。
- 每当你修了一个 bug， 都要尽量写一个回归测试。 如果一个 bug 修复了，没有回归测试，很可能以后会再次出问题。




## 公共约束

### 注释

- 多行注释用 `/** ... */`

```javascript
// bad
// make() returns a new element
// based on the passed in tag name
//
// @param {String} tag
// @return {Element} element
function make(tag) {

  // ...

  return element;
}

// good
/**
 * make() returns a new element
 * based on the passed-in tag name
 */
function make(tag) {

  // ...

  return element;
}
```

- 单行注释用 `//`

```javascript
// bad
const active = true;  // is current tab

// good
// is current tab
const active = true;

// bad
function getType() {
  console.log('fetching type...');
  // set the default type to 'no type'
  const type = this._type || 'no type';

  return type;
}

// good
function getType() {
  console.log('fetching type...');

  // set the default type to 'no type'
  const type = this._type || 'no type';

  return type;
}

// also good
function getType() {
  // set the default type to 'no type'
  const type = this._type || 'no type';

  return type;
}
```

- 用 `// FIXME:` 给问题注释,用 `// TODO:` 去注释待办

### 分号

> 为什么？当 JavaScript 遇到没有分号结尾的一行，它会执行 [自动插入分号](https://tc39.github.io/ecma262/#sec-automatic-semicolon-insertion) 这一规则来决定行末是否加分号。如果 JavaScript 在你的断行里错误的插入了分号，就会出现一些古怪的行为。显式配置代码检查去检查没有带分号的地方可以帮助你防止这种错误。

```javascript
// bad - raises exception
const luke = {}
const leia = {}
[luke, leia].forEach((jedi) => jedi.father = 'vader')

// bad - raises exception
const reaction = "No! That’s impossible!"
(async function meanwhileOnTheFalcon() {
  // handle `leia`, `lando`, `chewie`, `r2`, `c3p0`
  // ...
}())

// bad - returns `undefined` instead of the value on the next line - always happens when `return` is on a line by itself because of ASI!
function foo() {
  return
    'search your feelings, you know it to be foo'
}

// good
const luke = {};
const leia = {};
[luke, leia].forEach((jedi) => {
  jedi.father = 'vader';
});

// good
const reaction = "No! That’s impossible!";
(async function meanwhileOnTheFalcon() {
  // handle `leia`, `lando`, `chewie`, `r2`, `c3p0`
  // ...
}());

// good
function foo() {
  return 'search your feelings, you know it to be foo';
}
```


### 命名规范

- `export default` 导出模块A，则这个文件名也叫 `A.*`， `import` 时候的参数也叫 `A` :

```javascript
// file 1 contents
class CheckBox {
  // ...
}
export default CheckBox;

// file 2 contents
export default function fortyTwo() { return 42; }

// file 3 contents
export default function insideDirectory() {}

// in some other file
// bad
import CheckBox from './checkBox'; // PascalCase import/export, camelCase filename
import FortyTwo from './FortyTwo'; // PascalCase import/filename, camelCase export
import InsideDirectory from './InsideDirectory'; // PascalCase import/filename, camelCase export

// bad
import CheckBox from './check_box'; // PascalCase import/export, snake_case filename
import forty_two from './forty_two'; // snake_case import/filename, camelCase export
import inside_directory from './inside_directory'; // snake_case import, camelCase export
import index from './inside_directory/index'; // requiring the index file explicitly
import insideDirectory from './insideDirectory/index'; // requiring the index file explicitly

// good
import CheckBox from './CheckBox'; // PascalCase export/import/filename
import fortyTwo from './fortyTwo'; // camelCase export/import/filename
import insideDirectory from './insideDirectory'; // camelCase export/import/directory name/implicit "index"
// ^ supports both insideDirectory.js and insideDirectory/index.js
```

- 当你`export default`一个函数时，函数名用小驼峰，文件名和函数名一致, export 一个结构体/类/单例/函数库/对象 时用大驼峰。

```javascript
function makeStyleGuide() {
  // ...
}

export default makeStyleGuide;



const AirbnbStyleGuide = {
  es6: {
  }
};

export default AirbnbStyleGuide;
```


### 标准库

> [标准库](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects)中包含一些由于历史原因遗留的工具类

- 用 `Number.isNaN` 代替全局的 `isNaN`:

  ```javascript
  // bad
  isNaN('1.2'); // false
  isNaN('1.2.3'); // true
  
  // good
  Number.isNaN('1.2.3'); // false
  Number.isNaN(Number('1.2.3')); // true
  ```

- 用 `Number.isFinite` 代替 `isFinite`

```javascript
// bad
isFinite('2e3'); // true

// good
Number.isFinite('2e3'); // false
Number.isFinite(parseInt('2e3', 10)); // true
```


## 类与函数

### 函数

- 使用命名函数表达式而不是函数声明

  > 为什么？这是因为函数声明会发生提升，这意味着在一个文件里函数很容易在其被定义之前就被引用了。这样伤害了代码可读性和可维护性。如果你发现一个函数又大又复杂，且这个函数妨碍了这个文件其他部分的理解性，你应当单独把这个函数提取成一个单独的模块。不管这个名字是不是由一个确定的变量推断出来的，别忘了给表达式清晰的命名（这在现代浏览器和类似 babel 编译器中很常见）。这消除了由匿名函数在错误调用栈产生的所有假设。 ([讨论](https://github.com/airbnb/javascript/issues/794))

  ```javascript
  // bad
  function foo() {
    // ...
  }
  
  // bad
  const foo = function () {
    // ...
  };
  
  // good
  // lexical name distinguished from the variable-referenced invocation(s)
  // 函数表达式名和声明的函数名是不一样的
  const short = function longUniqueMoreDescriptiveLexicalFoo() {
    // ...
  };
  ```

  

- 把立即执行函数包裹在圆括号里:

  > 立即执行函数：Immediately Invoked Function expression = IIFE。 为什么？因为这样使代码读起来更清晰（译者注：我咋不觉得）。 另外，在模块化世界里，你几乎用不着 IIFE。

  ```javascript
  // immediately-invoked function expression (IIFE)
  ( ()=> {
    console.log('Welcome to the Internet. Please follow me.');
  }() );
  ```

- 不要用 `arguments` 命名参数。他的优先级高于每个函数作用域自带的 `arguments` 对象，这会导致函数自带的 `arguments` 值被覆盖:

  ```javascript
  // bad
  function foo(name, options, arguments) {
    // ...
  }
  
  // good
  function foo(name, options, args) {
    // ...
  }
  ```

- 用默认参数语法而不是在函数里对参数重新赋值

  ```javascript
  // really bad
  function handleThings(opts) {
    // 如果 opts 的值为 false, 它会被赋值为 {}
    // 虽然你想这么写，但是这个会带来一些微妙的 bug。
    opts = opts || {};
    // ...
  }
  
  // still bad
  function handleThings(opts) {
    if (opts === void 0) {
      opts = {};
    }
    // ...
  }
  
  // good
  function handleThings(opts = {}) {
    // ...
  }
  ```

- 把默认参数赋值放在最后面

  ```javascript
  // bad
  function handleThings(opts = {}, name) {
    // ...
  }
  
  // good
  function handleThings(name, opts = {}) {
    // ...
  }
  ```

- 不要修改参数，也不要重新对函数参数赋值：

  > 容易导致bug，另外重新对参数赋值也会导致优化问题。

  ```javascript
  // bad
  function f1(a) {
    a = 1;
    // ...
  }
  
  function f2(a) {
    if (!a) { a = 1; }
    // ...
  }
  
  // good
  function f3(a) {
    const b = a || 1;
    // ...
  }
  
  function f4(a = 1) {
    // ...
  }
  ```

  



### 箭头函数

- 当需要使用箭头函数的时候，使用它，但是不要滥用

  > 当函数逻辑复杂时，不推荐使用箭头函数，而是单独抽出来放在一个函数里。

  ```javascript
  // bad
  [1, 2, 3].map(function (x) {
    const y = x + 1;
    return x * y;
  });
  
  // good
  [1, 2, 3].map((x) => {
    const y = x + 1;
    return x * y;
  });
  ```

- 避免箭头函数与比较操作符混淆

  ```javascript
  // bad
  const itemHeight = (item) => item.height <= 256 ? item.largeSize : item.smallSize;
  
  // bad
  const itemHeight = (item) => item.height >= 256 ? item.largeSize : item.smallSize;
  
  // good
  const itemHeight = (item) => (item.height <= 256 ? item.largeSize : item.smallSize);
  
  // good
  const itemHeight = (item) => {
    const { height, largeSize, smallSize } = item;
    return height <= 256 ? largeSize : smallSize;
  };
  ```

  

### 类与构造函数

- 使用`class` 语法。避免直接操作 `prototype`

  ```javascript
  // bad
  function Queue(contents = []) {
    this.queue = [...contents];
  }
  Queue.prototype.pop = function () {
    const value = this.queue[0];
    this.queue.splice(0, 1);
    return value;
  };
  
  // good
  class Queue {
    constructor(contents = []) {
      this.queue = [...contents];
    }
    pop() {
      const value = this.queue[0];
      this.queue.splice(0, 1);
      return value;
    }
  }

- 用 `extends` 实现继承:

  > 为什么？它是一种内置的方法来继承原型功能而不破坏 `instanceof`

  ```javascript
  // bad
  const inherits = require('inherits');
  function PeekableQueue(contents) {
    Queue.apply(this, contents);
  }
  inherits(PeekableQueue, Queue);
  PeekableQueue.prototype.peek = function () {
    return this.queue[0];
  }
  
  // good
  class PeekableQueue extends Queue {
    peek() {
      return this.queue[0];
    }
  }
  ```

  

- 方法可以返回 `this` 来实现链式调用

```javascript
// bad
Jedi.prototype.jump = function () {
  this.jumping = true;
  return true;
};

Jedi.prototype.setHeight = function (height) {
  this.height = height;
};

const luke = new Jedi();
luke.jump(); // => true
luke.setHeight(20); // => undefined

// good
class Jedi {
  jump() {
    this.jumping = true;
    return this;
  }

  setHeight(height) {
    this.height = height;
    return this;
  }
}

const luke = new Jedi();

luke.jump()
  .setHeight(20);
```



- 自定义 `toString()` 方法是可以的，但需要保证它可以正常工作

```javascript
class Jedi {
  constructor(options = {}) {
    this.name = options.name || 'no name';
  }

  getName() {
    return this.name;
  }

  toString() {
    return `Jedi - ${this.getName()}`;
  }
}
```

- 如果没有特别定义，类有默认的构造方法。一个空的构造函数或只是代表父类的构造函数是不需要写的。

```javascript
// bad
class Jedi {
  constructor() {}

  getName() {
    return this.name;
  }
}

// bad
class Rey extends Jedi {
  // 这种构造函数是不需要写的
  constructor(...args) {
    super(...args);
  }
}

// good
class Rey extends Jedi {
  constructor(...args) {
    super(...args);
    this.name = 'Rey';
  }
}
```



### 模块

- 使用（`import`/`export`）模块

```javascript
// bad
const AirbnbStyleGuide = require('./AirbnbStyleGuide');
module.exports = AirbnbStyleGuide.es6;

// ok
import AirbnbStyleGuide from './AirbnbStyleGuide';
export default AirbnbStyleGuide.es6;

// best
import { es6 } from './AirbnbStyleGuide';
export default es6;
```

- 不要导出可变的东西:

> 变化通常都是需要避免，特别是当你要输出可变的绑定。虽然在某些场景下可能需要这种技术，但总的来说应该导出常量。

```javascript
// bad
let foo = 3;
export { foo }

// good
const foo = 3;
export { foo }
```

- import JavaScript文件不用包含扩展名

```javascript
// bad
import foo from './foo.js';
import bar from './bar.jsx';
import baz from './baz/index.jsx';

// good
import foo from './foo';
import bar from './bar';
import baz from './baz';
```



### 迭代器与生成器

- 不要用迭代器。使用 JavaScript 高级函数代替 `for-in`、 `for-of`

  > 用数组的这些迭代方法： `map()` / `every()` / `filter()` / `find()` / `findIndex()` / `reduce()` / `some()` / ... , 对象的这些方法 `Object.keys()` / `Object.values()` / `Object.entries()` 得到一个数组，就能去遍历对象。

  ```javascript
  const numbers = [1, 2, 3, 4, 5];
  
  // bad
  let sum = 0;
  for (let num of numbers) {
    sum += num;
  }
  sum === 15;
  
  // good
  let sum = 0;
  numbers.forEach((num) => sum += num);
  sum === 15;
  
  // best (use the functional force)
  const sum = numbers.reduce((total, num) => total + num, 0);
  sum === 15;
  
  // bad
  const increasedByOne = [];
  for (let i = 0; i < numbers.length; i++) {
    increasedByOne.push(numbers[i] + 1);
  }
  
      // good
  const increasedByOne = [];
  numbers.forEach((num) => {
    increasedByOne.push(num + 1);
  });
  
  // best (keeping it functional)
  const increasedByOne = numbers.map((num) => num + 1);
  ```


### 提升

- `var` 声明会被提前到离他最近的作用域的最前面，但是它的赋值语句并没有提前。`const` 和 `let` 被赋予了新的概念 [暂时性死区 (TDZ)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let#temporal_dead_zone_tdz)。 重要的是要知道为什么 [typeof 不再安全](https://web.archive.org/web/20200121061528/http://es-discourse.com/t/why-typeof-is-no-longer-safe/15)。

```javascript
// 我们知道这个不会工作，假设没有定义全局的 notDefined
function example() {
  console.log(notDefined); // => throws a ReferenceError
}

// 在你引用的地方之后声明一个变量，他会正常输出是因为变量提升。
// 注意： declaredButNotAssigned 的值 true 没有被提升。
function example() {
  console.log(declaredButNotAssigned); // => undefined
  var declaredButNotAssigned = true;
}

// 可以写成如下例子， 二者意义相同。
function example() {
  let declaredButNotAssigned;
  console.log(declaredButNotAssigned); // => undefined
  declaredButNotAssigned = true;
}

// 用 const，let就不一样了。
function example() {
  console.log(declaredButNotAssigned); // => throws a ReferenceError
  console.log(typeof declaredButNotAssigned); // => throws a ReferenceError
  const declaredButNotAssigned = true;
}
```

- 已命名函数表达式提升他的变量名，不是函数名或函数体

```javascript
function example() {
  console.log(named); // => undefined

  named(); // => TypeError named is not a function

  superPower(); // => ReferenceError superPower is not defined

  var named = function superPower() {
    console.log('Flying');
  };
}

// 函数名和变量名一样是也如此。
function example() {
  console.log(named); // => undefined

  named(); // => TypeError named is not a function

  var named = function named() {
    console.log('named');
  };
}
```

### 比较运算符与相等

- 用 `===` 和 `!==` 严格比较而不是 `==` 和 `!=`

- 条件语句，例如if语句使用coercion与tobooleant抽象方法评估它们的表达式，始终遵循这些简单的规则：
  - **Objects** evaluate to **true**
  - **Undefined** evaluates to **false**
  - **Null** evaluates to **false**
  - **Booleans** evaluate to **the value of the boolean**
  - **Numbers** evaluate to **false** if **+0, -0, or NaN**, otherwise **true**
  - **Strings** evaluate to **false** if an empty string `''`, otherwise **true**

```javascript
if ([0] && []) {
  // true
  // an array (even an empty one) is an object, objects will evaluate to true
}
```

- 三元表达式不应该嵌套，尽量保持单行表达式

```javascript
// bad
const foo = maybe1 > maybe2
  ? "bar"
  : value1 > value2 ? "baz" : null;

// better
const maybeNull = value1 > value2 ? 'baz' : null;

const foo = maybe1 > maybe2
? 'bar'
  : maybeNull;

// best
const maybeNull = value1 > value2 ? 'baz' : null;

const foo = maybe1 > maybe2 ? 'bar' : maybeNull;
```

### 事件

- 当把数据载荷传递给事件时（例如是 DOM 还是像 Backbone 这样有很多属性的事件）。这使得后续的贡献者（程序员）向这个事件添加更多的数据时不用去找或者更新每个处理器。

```javascript
// bad
$(this).trigger('listingUpdated', listing.id);

// ...

$(this).on('listingUpdated', (e, listingID) => {
  // do something with listingID
});
```


### 类型转换与强制转换

- 字符串

```javascript
// => this.reviewScore = 9;

// bad
const totalScore = new String(this.reviewScore); // typeof totalScore is "object" not "string"

// bad
const totalScore = this.reviewScore + ''; 

// bad
const totalScore = this.reviewScore.toString(); // 不保证返回 string

// good
const totalScore = String(this.reviewScore);
```

- 数字: 用 `Number` 做类型转换，`parseInt` 转换 `string` 应总是带上进制位

```javascript
const inputValue = '4';

// bad
const val = new Number(inputValue);

// bad
const val = +inputValue;

// bad
const val = inputValue >> 0;

// bad
const val = parseInt(inputValue);

// good
const val = Number(inputValue);

// good
const val = parseInt(inputValue, 10);
```

- 移位运算要小心

  > 移位运算对大于 32 位的整数会导致意外行为。[Discussion](https://github.com/airbnb/javascript/issues/109). 最大的 32 位整数是 2,147,483,647:

```javascript
2147483647 >> 0 //=> 2147483647
2147483648 >> 0 //=> -2147483648
2147483649 >> 0 //=> -2147483647
```

## 推荐资源
- 网站：
  - [MDN](https://developer.mozilla.org/zh-CN/docs/Web/): 不管你是仅仅开始入门、学过一点基础或者是个网站开发老手，你都能在这里找到有用的资源。
  - [JS周刊](https://javascriptweekly.com/) : 你可以在这里，接收到JS社区里最新的动态，其他开发者编写的优秀工具，阅读优秀的文章。
  - [印记中文](https://docschina.org/) : JS及其前端领域的文档集合。

- 书籍(为了尊重作者的版权，下列书籍仅开源书籍提供链接)：
  - JavaScript权威指南（原书第7版）
  - [你不知道的JS](https://github.com/getify/You-Dont-Know-JS)
  - [Eloquent JavaScript](https://eloquentjavascript.net/)