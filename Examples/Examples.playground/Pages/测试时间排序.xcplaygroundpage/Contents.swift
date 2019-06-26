//: [Previous](@previous)

import Foundation
import SwifterSwift

class Article {
    var name: String?
    var dateString: String

    init(dateString: String) {
        self.dateString = dateString
    }
}

let arr = ["2019/06/02", "2019/06/02", "2019/06/07", "2019/03/03", "2019/03/02", "2019/03/02", "2018/07/22", "2018/07/22"]

var lastYear = 0
var lastDay = ""

var resultArr = [String]()

for item in arr {
    let dateformater = DateFormatter()
    dateformater.dateFormat = "yyyy/MM/dd"
    let date = dateformater.date(from: item)!

    defer {
        lastDay = item
        lastYear = date.year
    }

    var showYear = false
    var showDay = false

    if date.year != lastYear {
        showYear = true
    }

    if lastDay != item {
        showDay = true
    }

    // 用于显示的月日
    let mdString = date.string(withFormat: "dd/MM")

    if showYear {
        // 年不一样 day 肯定不一样
        resultArr.append("\(date.year)\n\(mdString)")
    } else if showDay {
        resultArr.append("\(mdString)")
    } else {
        resultArr.append("同上")
    }
}

print(resultArr)

let jsonData = JSONSerialization.data(withJSONObject: resultArr, options: JSONSerialization.WritingOptions())

print(String.init(data: jsonData, encoding: .utf8))

DateFormatter.initWith(format: "yyy/MM/dd").string(from: Date())
//: [Next](@next)
