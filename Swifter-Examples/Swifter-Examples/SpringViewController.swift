//
//  SpringViewController.swift
//  Swifter-Examples
//
//  Created by yanglin on 2019/5/27.
//  Copyright © 2019 yanglin
//

import UIKit

class SpringViewController: UIViewController {

    @IBOutlet weak var circleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        circleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.circleView.transform = .identity
        }, completion: nil)

    }

}
