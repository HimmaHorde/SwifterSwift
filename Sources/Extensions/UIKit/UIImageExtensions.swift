//
//  UIImageExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)
import UIKit

// MARK: - Properties
public extension UIImage {

    /// 图片的大小 单位:bytes
    var bytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }

    /// 图片大小 单位:KB ; 1KB = 1024Bytes
    var kilobytesSize: Int {
        return bytesSize / 1024
    }

    /// 始终使用原图模式
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    /// 始终使用渲染模式
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }

}

// MARK: - Methods
public extension UIImage {

    /// SwifterSwift: 压缩图片质量,并返回压缩后的 UIImage。
    ///
    /// - Parameter quality: 生成的JPEG图像的质量，表示为从0.0到1.0的值。值0.0表示最大压缩(或最低质量)，值1.0表示最小压缩(或最佳质量)，(默认值为0.5)。
    /// - Returns: 压缩后图片,可能为空。
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// SwifterSwift: 压缩图片质量,返回压缩后的 Data。
    ///
    /// - Parameter quality: 压缩系数 0 - 1;默认0.5。
    /// - Returns: 压缩后的 Data
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }

    /// 剪切指定位置的图片。
    ///
    /// - Parameter rect: 位置。
    /// - Returns: 剪切后图片
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width < size.width && rect.size.height < size.height else { return self }
        guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
        return UIImage(cgImage: image)
    }

    /// UIImage根据高宽比缩放。
    ///
    /// - Parameters:
    ///   - toHeight: 指定高度。
    ///   - opaque: 是否保留透明度。
    /// - Returns: 缩放后的image。
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, 0)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// UIImage根据宽高比缩放。
    ///
    /// - Parameters:
    ///   - toWidth: 指定宽度。
    ///   - opaque: 位图是否不透明标志。
    /// - Returns: 缩放后的image。
    func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, 0)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 生成旋转指定角度的图片
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: Measurement(value: 180, unit: .degrees))
    ///
    /// - Parameter angle: 旋转的度数
    /// - Returns: 以给定角度旋转的新图像。
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, *)
    func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)

        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 生成旋转给定弧度值的图片 (in radians).
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    ///
    /// - Parameter radians: 以弧度表示的用来旋转图像的角度。
    /// - Returns: 以给定角度旋转的新图像。
    func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 图片使用单色填充
    ///
    /// - Parameter color: 填充色
    /// - Returns: 填充后的新图
    func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 新图使用指定混合模式和颜色添加一个纯色填充图层
    ///
    ///       //实际使用效果类似于 PS 的图层混合模式 eg.正片叠底
    ///       let image = UIImage.init(named: "TestImage.png")!
    ///       image.blend(UIColor.red, mode: .multiply)
    ///
    /// - Parameters:
    ///   - color: 填充色
    ///   - mode: 填充模式
    /// - Returns: 生成的图片
    func blend(_ color: UIColor, mode: CGBlendMode) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }

        draw(in: rect)

        // 旋转画布用于添加填充层
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(mode)

        // 添加填充层
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        context.scaleBy(x: 1.0, y: -1.0)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 带圆角的图片
    ///
    /// - Parameters:
    ///   - radius: 角半径(可选)，生成的图像将是圆的，如果没有指定
    /// - Returns: 圆角图
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}

// MARK: - Initializers
public extension UIImage {

    /// 生成指定颜色和尺寸的图片
    ///
    /// - Parameters:
    ///   - color: 填满色
    ///   - size: 图片尺寸
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)

        defer {
            UIGraphicsEndImageContext()
        }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: aCgImage)
    }

}
#endif
