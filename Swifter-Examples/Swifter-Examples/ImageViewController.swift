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
            imageView.image = UIImage.init(named: "wall.png")?.tint(UIColor.red, blendMode: .destinationIn, alpha: 0.8)
        case 2:
            let original = UIImage.init(named: "xiaofang")!
            print("original size = \(original.size)")
            imageView.image = original.cropped(to: CGRect.init(x: 0, y: 0, width: 270, height: 300))
            print(imageView.image?.size ?? "nil")
            print(imageView.image?.scale ?? "nil")
        case 4:
            imageView.image = UIImage.init(named: "wall.png")?.masked(withColor: UIColor.init(hex: 0x000000, transparency: 0.5)!)
        case 5:
            let oImage = UIImage.init(named: "wall.png")!
            let temp = oImage.scaled(toWidth: 100)
            print("original \(oImage.size)")
            print("scaled \(temp!.size)")
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

extension UIImage {
    func changeColor(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
            // 方式一（可以）
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
            let context = UIGraphicsGetCurrentContext()
            color.setFill()
            // 移动图片
            context!.translateBy(x: 0, y: self.size.height)
            context!.scaleBy(x: 1.0, y: -1.0)

            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            context!.draw(self.cgImage!, in: rect)
            // 模式配置
            context!.setBlendMode(blendMode)
//            context!.addRect(rect)
//            context!.drawPath(using: CGPathDrawingMode.fill)
            context?.fill(rect)
            // 创建获取图片
            let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return coloredImage!
    }
    func filled2(withColor color: UIColor) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        color.setFill()
        context.fill(CGRect.init(origin: .zero, size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
