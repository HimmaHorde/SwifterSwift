//
//  ViewController.swift
//  Swifter-Examples
//
//  Created by yanglin on 2019/2/25.
//  Copyright © 2019 yanglin
//

import UIKit
import SwifterSwift

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(text: "asdasfdfssfdgfhgfdsdf", style: .headline)
        view.addSubview(label)
        label.frame = CGRect.init(x: 100, y: 100, width: 200, height: 50)
        label.font = label.font.bold

        textField.text = "   阿萨德你看三大看点阿斯顿撒U盾哈可达爱仕达大所暗色调 as 大大的 ad \n 打算打双打实打实大四U盾还U盾和我   \n\n\n"

//        if let data = try? FileManager.default.jsonFromFile(withFilename: "data") {
//            print(data)
//        } else {
//            print("获取不到地址")
//        }
        let pathArr = "mp3".components(separatedBy: ".")
        print(pathArr)




    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(textField.trimmedText!)
    }

}
