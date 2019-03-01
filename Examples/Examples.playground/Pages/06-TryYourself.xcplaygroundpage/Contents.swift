//: [Table of Contents](00-ToC)

//: [Previous](@previous)

import SwifterSwift

//: ## Try yourself
//: *Here you can try some extensions yourself*

class Person {
    public var age: Int = 0
    init(age: Int) {
        self.age = age
    }
}

let p1 = Person.init(age: 100)
let p2 = Person.init(age: 88)
let p3 = Person.init(age: 101)

let arr = [p1, p2, p3]

let temp = arr.sorted(by: \Person.age)

var numArray = ["aaa", "aaaa"]

//numArray.removeAll { (num) -> Bool in
//    return num > 5
//}

numArray.reduce(into: [Int]()) {
    print($0)
    print($1)
}

let url = NSURL.init(string: "https://www.google.com/m/ald/cc.html")

print(url?.scheme)
print(url?.path)

//
let queueArr = [1, 2, 3, 4, 5]

DispatchQueue.concurrentPerform(iterations: queueArr.count) { (index) in
    print("index = \(index) ，线程\(Thread.current)")
}

if "c" ~= "a"..."f" {
    print("1在数组当中")
}

let dic = ["key1": "value1", "key2": "value2", "key3": "value3"]

var aDic = ["key1": "value"]
let bDic = ["key2": "value2"]

//let newDic =  dic.mapKeysAndValues { (key, value) -> (String, String) in
//    let newKey = "A\(key)"
//    return (newKey, value)
//}

//let newDic = dic.map { (key, value) -> (String, String) in
//    return("BB\(key)", value)
//}

//print(newDic)
let num = 123456789
print(num.digits)// ->[1, 2, 3, 4, 5, 6, 7, 8, 9]
print(num.digitsCount)

let str1 = "hello " + "world"

//extension String {
//    infix operator 
//}

var color = #colorLiteral(red: 0, green: 0.4509803922, blue: 0.9725490196, alpha: 1)
print(color.hexString)
let c2 = color.complementary
print(color.complementary)
print(color)

let today = Date.init(timeIntervalSinceNow: 0)
print(today.monthName())

let pathString = ".mp3"

let pathComponents = pathString.components(separatedBy: ".")

print(pathComponents)

//let url = URL.init(string: "http://www.baidu.com?name=yanglin&age=100")
//
//print(url?.queryParameters) // -> Optional(["name": "yanglin", "age": "100"])




//: [Previous](@previous)
