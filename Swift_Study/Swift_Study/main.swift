//
//  main.swift
//  Swift_Study
//
//  Created by Roger Yee on 2/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import Foundation

// 区间运算符
for iCount in 1...10 {
    if (iCount%2)==0 {
        println("the cow is \(iCount)")
    }
}

// Closure Sample
func printMsg(msg:String, format:(String)->String){
    var result = msg + format(msg)
    println(result)
}

func sayHi(s1:String)->String{
    return "Hi " + s1
}

// Pass a function as the parameter
printMsg("Roger",sayHi)

// Pass a closure function as the parameter
printMsg("Roger",{(name:String)->String in return "Hello " + name})

// Omit the type of parameter of closure function
printMsg("Roger",{name in "Hello " + name})

// Omit the "return" keywords if the body of closure only contains one statement.
// Also use $0,$1,.. instead of defining the parameter
printMsg("Roger",{"Hello " + $0})

// Use Trailing closure
// Trailing 闭包是一个书写在函数括号之外(之后)的闭包表达式，函数支持将其作为最后一个参数调用。
printMsg("Roger"){"Good morning, " + $0}


var stringArray = Array<String>()
stringArray.append("1")
stringArray.append("2")
stringArray.append("3")

var myDict = ["1":"Roger","2":"Phoebe"]
myDict.values
myDict.keys

// 结构体
struct bookInfo {
    var ID:Int = 0
    var Name:String = "Default"
    var Author:String = "Default"
}

var book = bookInfo(ID:2001,Name:"HI SHANGHAI", Author:"Roger")
var author = book.Author
author = "Phoebe"
// 结构体是值类型，会被复制，所以book.Author!=author
println("book.author is \(book.Author)")

// 枚举
enum PointRect {
    case top
    case bottom
    case right
    case left
}

// Class
class Student{
    var name:String = "" {
        
        // Attribute Observer
        didSet {
            println("Set new name=(\(self.name)) for student to replace the old name = [\(oldValue)]")
        }
    }
    
    var classno:Int = 0
    var from:String = ""
    
    // Computed attribute
    var fullName:String {
        get {
            return "My Name is " + self.name
        }
        set(value) {
            self.name = value
        }
    }
    
    // 类的静态属性，用class关键字修饰
    class var country:String {
        return "China"
    }
}

var student = Student()
student.name = "Roger"
println("name=\(student.fullName)， country=\(Student.country)")

student.fullName = "Phoebe"
println("name=\(student.fullName)")


// Subscript
class SubString {

    var str:String = ""
    init(str:String) {
        self.str = str
    }
    
    subscript(start:Int, length:Int) -> String {
    
        return (str as NSString).substringWithRange(NSRange(location:start, length:length))
    }
    
    subscript(index:Int) -> String {
        return String(Array(str)[index])
    }
}

var str = SubString(str:"China Beijing")
println(str[6,7])
println(str[6])

// OOP
protocol Person {
    func sayHi()
}

class Parent : Person{

    var name:String = "Parent"
    var address:String = "Shanghai"
    
    func sayHi() {
        println("Hi I am parent!")
    }
}

class Child : Parent {
    
    override func sayHi() {
        println("Hi I am child")
    }
}

var child = Child()
child.sayHi()

// Extended a Class
extension Child {
    
    func sing() {
        println("Child is singing")
    }
}

child.sing()

// Optional Value
class StudentOV {
    var country:Country?
}

class Country {
    var name:String = "China"
}

var roger = StudentOV()
println(roger.country)
roger.country = Country()
println(roger.country!.name)

var optionalValue:String? = "HasValue"
if let ov = optionalValue {
    println(optionalValue!)
}

// Generic Type
class StudentGT : Hashable{
    var no:Int?
    var name:String?
    
    var hashValue:Int {
        return self.no!
    }
}

class SchoolGT {
    var name:String?
    var addr:String?
}

func ==(lhs: StudentGT, rhs: StudentGT) -> Bool{
    return lhs.no == rhs.no
}

var students:Dictionary<StudentGT,SchoolGT> = Dictionary()







