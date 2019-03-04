//
//  ViewController.swift
//  Swifter-Examples
//
//  Created by yanglin on 2019/2/25.
//  Copyright © 2019 yanglin
//

import UIKit
import SwifterSwift

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!

    @IBOutlet var imageView: UIImageView!

    var debounceTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.FlatUI.turquoise

    }

    // 模拟用户输入文字，并即时请求结果

    // 文字改变
    func textChanged() {
        if let timer = debounceTimer {
            // 取消上一个网络请求
            timer.invalidate()
        }
        // 准备一个新的请求
        debounceTimer = Timer(timeInterval: 1.0, target: self, selector:#selector(ViewController.search) , userInfo: nil, repeats: false)
        RunLoop.current.add(debounceTimer!, forMode: .common)
    }

    // MARK: private
    /// 开始新的请求
    @objc func search() {
        print(textField.text ?? "")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textChanged()
        return true
    }

}
