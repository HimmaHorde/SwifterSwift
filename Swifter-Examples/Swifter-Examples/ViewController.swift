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

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(text: "asdasfdfssfdgfhgfdsdf", style: .headline)
        view.addSubview(label)
        label.frame = CGRect.init(x: 100, y: 100, width: 200, height: 50)
        label.font = label.font.bold
    }


}

