//: [Table of Contents](00-ToC)

//: [Previous](@previous)

import SwifterSwift

//: ## Try yourself
//: *Here you can try some extensions yourself*

let image = UIImage.init(named: "TestImage.png")!

let mutiplyImage = image.blend(UIColor.red, mode: .multiply)

let cc:Character = "a"

class MyCell: UITableViewCell {

}

class HerCell: UITableViewCell {

}

let tableView = UITableView.init()

var cellArr = [MyCell.self,HerCell.self]
//tableView.registerNibs(with: [MyCell.self,HerCell.self])
//tableView.register(nibWithCellClass: [MyCell.self,HerCell.self] as! [UITableViewCell.Type])
tableView.register(nibWithClasses: [MyCell.self,HerCell.self])
tableView.register(nibWithClasses: MyCell.self,HerCell.self)


//: [Previous](@previous)
