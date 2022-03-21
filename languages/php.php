<?php

/**
 * Class 
 * http://php.net/manual/zh/language.oop5.basic.php
 */
class NormalClass extends AbstractClassName implements InterfaceName
{
    // 引用 Trait (为 PHP 提供多继承的能力，可理解为代码复制)
    use TraitName;

    // --> 类属性类型 <--

    /**
     * 公有的类成员可以在任何地方被访问，会被继承。
     * @var Type
     */
    public $property;

    /**
     * 私有的类成员则只能被其定义所在的类访问，不会被继承。
     * @var Type
     */
    private $property;

    /**
     * 受保护的类成员则可以被其自身以及其子类和父类访问，会被继承。
     * @var Type
     */
    protected $property;

    /**
     * 静态变量，也被称为类变量，所有对象的变量都是同一个。
     * @var Type
     */
    static $property;

    // --> 方法类型 <--

    /**
     * 公共方法，任何对象都能访问。
     * @param Type
     * @return Type
     */
    public function publicFunction(Type $var = null): Type
    {
    }

    /**
     * 私有方法，只有对象自身可以访问。
     * @param Type
     * @return Type
     */
    private function privateFunction(Type $var = null): Type
    {
    }

    /**
     * 保护方法，只有自身和子类可以访问。
     * @param Type
     * @return Type
     */
    protected function protectedFunction(Type $var = null): Type
    {
    }
    
    /**
     * 静态方法，可以在不实例化类的情况下执行。
     * @param Type
     * @return Type
     */
    public static function staticFunction(Type $var = null): Type
    {
    }

    // --> 魔术方法 <--

    /**
     * 具有构造函数的类会在每次创建新对象时先调用此方法，所以非常适合在使用对象之前做一些初始化工作。
     * http://php.net/manual/zh/language.oop5.decon.php
     * @param Type
     * @return void
     */
    public function __construct(Type $var = null)
    {
    }

    /**
     * 析构函数会在到某个对象的所有引用都被删除或者当对象被显式销毁时执行。
     * http://php.net/manual/zh/language.oop5.decon.php
     * @return void
     */
    public function __destruct()
    {
    }

    /**
     * 在给不可访问属性赋值时，__set() 会被调用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @param mixed value
     * @return void
     */
    public function __set(string $name , mixed $value)
    {
    }

    /**
     * 读取不可访问属性的值时，__get() 会被调用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @return mixed
     */
    public function __get(string $name)
    {
    }

    /**
     * 当对不可访问属性调用 isset() 或 empty() 时，__isset() 会被调用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @return bool
     */
    public function __isset(string $name)
    {
    }

    /**
     * 当对不可访问属性调用 unset() 时，__unset() 会被调用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @return void
     */
    public function __unset(string $name)
    {
    }

    /**
     * 在对象中调用一个不可访问方法时，__call() 会被调用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @param array arguments
     * @return mixed
     */
    public function __call(string $name, array $arguments)
    {
    }

    /**
     * 在静态上下文中调用一个不可访问方法时，__callStatic() 会被调用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @param array arguments
     * @return mixed
     */
    public static function __callStatic(string $name, array $arguments)
    {
    }

    /**
     * serialize() 函数会检查类中是否存在一个魔术方法 __sleep()。
     * 如果存在，该方法会先被调用，然后才执行序列化操作。此功能可以用于清理对象，
     * 并返回一个包含对象中所有应被序列化的变量名称的数组。
     * 如果该方法未返回任何内容，则 NULL 被序列化，并产生一个 E_NOTICE 级别的错误。
     * http://php.net/manual/zh/language.oop5.magic.php#object.sleep
     * @return array
     */
    public function __sleep()
    {
    }

    /**
     * 与之相反，unserialize() 会检查是否存在一个 __wakeup() 方法。
     * 如果存在，则会先调用 __wakeup 方法，预先准备对象需要的资源。
     * http://php.net/manual/zh/language.oop5.magic.php#object.wakeup
     * @return void
     */
    public function __wakeup()
    {
    }

    /**
     * __toString() 方法用于一个类被当成字符串时应怎样回应。
     * 例如 echo $obj; 应该显示些什么。此方法必须返回一个字符串，
     * 否则将发出一条 E_RECOVERABLE_ERROR 级别的致命错误。
     * http://php.net/manual/zh/language.oop5.magic.php#object.tostring
     * @return string
     */
    public function __toString()
    {
    }

    /**
     * 当尝试以调用函数的方式调用一个对象时，__invoke() 方法会被自动调用。
     * http://php.net/manual/zh/language.oop5.magic.php#object.invoke
     * @param Type
     * @return mixed
     */
    public function __invoke(Type $var = null)
    {
    }

    /**
     * 自 PHP 5.1.0 起当调用 var_export() 导出类时，此静态 方法会被调用。
     * http://php.net/manual/zh/language.oop5.magic.php#object.set-state
     * @param array properties
     * @return object
     */
    public static function __set_state(array $properties)
    {
    }

    /**
     * 在使用 var_dump() 时，会被调用。
     * http://php.net/manual/zh/language.oop5.magic.php#object.debuginfo
     * @return array
     */
    public function __debugInfo()
    {
    }

}

/**
 * 接口
 * 任何实现接口的类，都必须实现接口中的方法。
 */
interface InterfaceName
{

    public function FunctionName(Type $var = null): Type;

}

/**
 * 抽象类
 * 抽象类中可以包含普通方法，和抽象方法。
 */
abstract class AbstractClassName
{

    /**
     * 继承本抽象类的类，必须实现抽象方法。
     * @param Type
     * @return Type
     */
    abstract function abstractFunction(Type $var = null): Type;

}

/**
 * Trait
 * 提供代码复用能力、多继承能力
 */
trait Logger
{
	public function log($message)
	{
		return $message;
	}
}

class WriteLog
{
    use Logger;
    
    public function main()
    {
        return $this->log();
    }
}

