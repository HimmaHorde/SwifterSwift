//
//  SearchViewController.swift
//  Swifter-Examples
//
//  Created by yanglin on 2019/3/4.
//  Copyright © 2019 yanglin
//
// 原生 API 实现用户输入的即时搜索逻辑
// 模拟用户输入文字，停止输入 1s 后发起网络请求

import UIKit
import SwifterSwift

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var searchLabel: UILabel!

    var debounceTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.FlatUI.turquoise
    }

    // 模拟用户输入文字，停止输入 1s 后发起网络请求

    // 文字改变
    func textChanged() {
        if let timer = debounceTimer {
            // 取消上一个网络请求
            timer.invalidate()
        }
        // 准备一个新的请求
        debounceTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(SearchViewController.search), userInfo: nil, repeats: false)
        RunLoop.current.add(debounceTimer!, forMode: .common)
    }

    // MARK: private
    /// 开始新的请求
    @objc func search() {
        print(textField.text ?? "")
        searchLabel.text = textField.text
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textChanged()
        return true
    }

}
