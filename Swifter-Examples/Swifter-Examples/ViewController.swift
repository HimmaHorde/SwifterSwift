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

    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.FlatUI.turquoise
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Request
        let url = URL(string: "http://www.runoob.com/try/demo_source/movie.mp4")!

        DispatchQueue.global().async {
            if let image = url.thumbnail() {
                DispatchQueue.main.async(execute: {
                    self.imageView.image = image
                })
            }

        }
    }

}
