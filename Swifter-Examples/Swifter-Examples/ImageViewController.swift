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
    @IBOutlet weak var imageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.roundCorners(.topLeft, radius: 10)
        imageView.addBorder(width: 1, color: UIColor.red, corners: .topLeft)
        imageView2.addBorder(width: 1, color: .red)
    }

    @IBAction func click(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            imageView.image = UIImage.init(named: "wall.png")?.filled(withColor: UIColor.red)
        case 1:
            imageView.image = UIImage.init(named: "wall.png")?.tint(UIColor.white, blendMode: .multiply)
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