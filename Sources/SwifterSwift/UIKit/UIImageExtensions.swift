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
        return (jpegData(compressionQuality: 1)?.count ?? 0) / 1024
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
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// SwifterSwift: 压缩图片质量,返回压缩后的 Data。
    ///
    /// - Parameter quality: 压缩系数 0 - 1;默认0.5。
    /// - Returns: 压缩后的 Data
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }

    /// 剪切指定位置的图片,图片scale等于原图。
    ///
    /// - Parameter rect: 位置。
    /// - Returns: 剪切后图片
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= size.width && rect.size.height <= size.height else { return self }
        let newRect = CGRect.init(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.width * scale, height: rect.height * scale)
        guard let image: CGImage = cgImage?.cropping(to: newRect) else { return self }
        return UIImage.init(cgImage: image, scale: self.scale, orientation: .up)
    }

    /// UIImage根据高宽比缩放。
    ///
    /// - Parameters:
    ///   - toHeight: 指定高度。
    ///   - opaque: 是否保留透明度。
    ///   - scale: -1: 原图scale（默认），0: 系统scale，>0 :自定义 scale
    /// - Returns: 缩放后的image。
    func scaled(toHeight: CGFloat, opaque: Bool = false, scale: CGFloat = -1) -> UIImage? {
        let aimScale = scale < 0 ? self.scale : scale
        let newWidth = size.width * (toHeight / size.height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, aimScale)
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
    ///   - scale: -1: 原图scale（默认），0: 系统scale，>0 :自定义 scale
    /// - Returns: 缩放后的image。
    func scaled(toWidth: CGFloat, opaque: Bool = false, scale: CGFloat = -1) -> UIImage? {
        let aimScale = scale < 0 ? self.scale : scale
        let newHeight = size.height * (toWidth / size.width)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, aimScale)
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

        #if !os(watchOS)
        if #available(iOS 10, tvOS 10, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            let renderer = UIGraphicsImageRenderer(size: size, format: format)
            return renderer.image { context in
                color.setFill()
                context.fill(CGRect(origin: .zero, size: size))
            }
        }
        #endif

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


    /// 生成添加半透明遮罩的图片
    ///
    /// - Parameter color: 使用有透明度的颜色
    /// - Returns: 新的图片
    func masked(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: rect, blendMode: .normal, alpha: 1)

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

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

    /// SwifterSwift: UIImage tinted with color
    ///
    /// - Parameters:
    ///   - color: color to tint image with.
    ///   - blendMode: how to blend the tint
    /// - Returns: UIImage tinted with given color.
    func tint(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: size)

        #if !os(watchOS)
        if #available(iOS 10.0, tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            return UIGraphicsImageRenderer(size: size, format: format).image { context in
                color.setFill()
                context.fill(drawRect)
                draw(in: drawRect, blendMode: blendMode, alpha: alpha)
            }
        }
        #endif

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    /// 为图片添加背景色
    ///
    /// - Parameters:
    ///   - backgroundColor: Color to use as background color
    /// - Returns: UIImage with a background color that is visible where alpha < 1
    func withBackgroundColor(_ backgroundColor: UIColor) -> UIImage {

        #if !os(watchOS)
        if #available(iOS 10.0, tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            return UIGraphicsImageRenderer(size: size, format: format).image { context in
                backgroundColor.setFill()
                context.fill(context.format.bounds)
                draw(at: .zero)
            }
        }
        #endif

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }

        backgroundColor.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        draw(at: .zero)

        return UIGraphicsGetImageFromCurrentImageContext()!
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

    /// SwifterSwift: Base 64 encoded PNG data of the image.
    ///
    /// - returns: Base 64 encoded PNG data of the image as a String.
    func pngBase64String() -> String? {
        return pngData()?.base64EncodedString()
    }

    /// SwifterSwift: Base 64 encoded JPEG data of the image.
    ///
    /// - parameter compressionQuality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    /// - returns: Base 64 encoded JPEG data of the image as a String.
    func jpegBase64String(compressionQuality: CGFloat) -> String? {
        return jpegData(compressionQuality: compressionQuality)?.base64EncodedString()
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

    /// SwifterSwift: Create a new image from a base 64 string.
    ///
    /// - Parameters:
    ///   - base64String: a base-64 `String`, representing the image
    ///   - scale: The scale factor to assume when interpreting the image data created from the base-64 string. Applying a scale factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a different scale factor changes the size of the image as reported by the `size` property.
    convenience init?(base64String: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }

    /// SwifterSwift: Create a new image from a URL
    ///
    /// - Important:
    ///   Use this method to convert data:// URLs to UIImage objects.
    ///   Don't use this synchronous initializer to request network-based URLs. For network-based URLs, this method can block the current thread for tens of seconds on a slow network, resulting in a poor user experience, and in iOS, may cause your app to be terminated.
    ///   Instead, for non-file URLs, consider using this in an asynchronous way, using `dataTask(with:completionHandler:)` method of the URLSession class or a library such as `AlamofireImage`, `Kingfisher`, `SDWebImage`, or others to perform asynchronous network image loading.
    /// - Parameters:
    ///   - url: a `URL`, representing the image location
    ///   - scale: The scale factor to assume when interpreting the image data created from the URL. Applying a scale factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a different scale factor changes the size of the image as reported by the `size` property.
    convenience init?(url: URL, scale: CGFloat = 1.0) throws {
        let data = try Data(contentsOf: url)
        self.init(data: data, scale: scale)
    }

}
#endif
