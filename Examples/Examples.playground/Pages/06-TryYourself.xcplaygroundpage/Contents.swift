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

print(numArray)

//: [Previous](@previous)
