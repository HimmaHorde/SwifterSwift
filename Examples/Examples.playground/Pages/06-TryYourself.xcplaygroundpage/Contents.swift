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

DispatchQueue.concurrentPerform(iterations: queueArr.count) { (i) in
    print("index = \(i) ，线程\(Thread.current)")
}

//: [Previous](@previous)
