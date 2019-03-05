//
//  ImageViewController.swift
//  Swifter-Examples
//
//  Created by yanglin on 2019/3/5.
//  Copyright © 2019 yanglin
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func click(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            imageView.image = UIImage.init(named: "wall.png")?.filled(withColor: UIColor.red)
        case 1:
            imageView.image = UIImage.init(named: "wall.png")?.tint(UIColor.red, blendMode: .clear)
        default:
            break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
