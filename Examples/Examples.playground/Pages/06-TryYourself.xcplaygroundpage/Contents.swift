//: [Table of Contents](00-ToC)

//: [Previous](@previous)

import SwifterSwift

//: ## Try yourself
//: *Here you can try some extensions yourself*

var value = 0
var count = 0
func incrementor() {
    value += 1
//    print()
    print("value = \(value)")
    print("count = \(count)")

}
// 1 秒执行一次
let debouncedIncrementor = SwifterSwift.debounce(millisecondsDelay: 2000) {
    incrementor()
}

for index in 1...6 {
    DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(1+index)) {
        debouncedIncrementor()
        count += 1
    }
}




//: [Previous](@previous)
