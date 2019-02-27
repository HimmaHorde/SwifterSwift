//: [Table of Contents](00-ToC)

//: [Previous](@previous)

import SwifterSwift

//: ## Try yourself
//: *Here you can try some extensions yourself*

var temp: String? = "Hello"

var temp1 = "sfs"
temp = nil

print(type(of: temp))
print(type(of: temp1))

var stringA = ""

if stringA.isEmpty {
    print( "stringA 是空的" )
} else {
    print( "stringA 不是空的" )
}

func testfunc(str: String?) {
    guard str == nil else {
        print("aaaaa")
        return }
}

struct NotifationTTT {

}
let customNotifation = NotifationTTT.init()
print(customNotifation)
//testfunc(str: "temp")
//
//let t = UITextField.init()
//
//t.text = temp
//
//print(t.text ?? "aaaa")
//print(temp)

let tableView = UITableView.init()
tableView.register(cellWithClass: UITableViewCell.self)

var corners: UIRectCorner =  .topLeft

corners = [ .topLeft, .bottomLeft ]

//: [Previous](@previous)
