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
        case 2:
            let original = UIImage.init(named: "xiaofang")!
            print("original size = \(original.size)")
            imageView.image = original.cropped(to: CGRect.init(x: 0, y: 0, width: 270, height: 300))
            print(imageView.image?.size ?? "nil")
            print(imageView.image?.scale ?? "nil")
        case 4:
            imageView.image = UIImage.init(named: "wall.png")?.masked(withColor: UIColor.init(hex: 0x000000, transparency: 0.5))
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
