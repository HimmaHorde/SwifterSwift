// ColorExtensions.swift - Copyright 2020 SwifterSwift

#if !os(Linux)

#if canImport(UIKit)
import UIKit
/// SS: Color
public typealias Color = UIColor
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
/// SS: Color
public typealias Color = NSColor
#endif

#if !os(watchOS)
import CoreImage
#endif

// MARK: - Properties

public extension Color {
    /// SS: 随机不透明颜色.
    static var random: Color {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return Color(red: red, green: green, blue: blue)!
    }

    /// SS: 获取颜色的 RGB 值，（0-255）表示。
    ///
    ///     UIColor.red.rgbComponents.red -> 255
    ///     NSColor.green.rgbComponents.green -> 255
    ///     UIColor.blue.rgbComponents.blue -> 255
    ///
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        let components: [CGFloat] = {
            let comps: [CGFloat] = cgColor.components!
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0))
    }

    /// SS: 获取颜色的 RGB 值小数表示，( 0 - 1)
    ///
    ///     UIColor.red.rgbComponents.red -> 1.0
    ///     NSColor.green.rgbComponents.green -> 1.0
    ///     UIColor.blue.rgbComponents.blue -> 1.0
    ///
    var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let components: [CGFloat] = {
            let comps: [CGFloat] = cgColor.components!
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: red, green: green, blue: blue)
    }

    /// SS: 获取 HSB 颜色的值 (read-only).
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    /// SS: 获取完整的16 进制字符串 (read-only).
    var hexString: String {
        let components: [Int] = {
            let comps = cgColor.components!.map { Int($0 * 255.0) }
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }

    /// SS: 获取短16 进制字符串
    ///
    ///     在16进制中，第一二位相同，第三四位相同， 第五六位相同，
    ///     可以简写为三位的16进制字符串。
    ///
    ///     let shortColocr = UIColor(hexString: "#ffeedd")
    ///     print(shortColocr.shortHexOrHexString) // #FED
    ///
    var shortHexString: String? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }

    /// SS: 返回十六进制字符串，对于符合short 规则的返回 `shortHexString`
    var shortHexOrHexString: String {
        let components: [Int] = {
            let comps = cgColor.components!.map { Int($0 * 255.0) }
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()
        let hexString = String(format: "#%02X%02X%02X", components[0], components[1], components[2])
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return hexString }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }

    /// SS: 颜色的透明度  (read-only).
    var alpha: CGFloat {
        return cgColor.alpha
    }

    #if !os(watchOS)
    /// SS: 使用颜色生成 CoreImage.CIColor (read-only)
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)
    }
    #endif

    /// SS: 颜色的 10 进制值
    var uInt: UInt {
        let components: [CGFloat] = {
            let comps: [CGFloat] = cgColor.components!
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()

        var colorAsUInt32: UInt32 = 0
        colorAsUInt32 += UInt32(components[0] * 255.0) << 16
        colorAsUInt32 += UInt32(components[1] * 255.0) << 8
        colorAsUInt32 += UInt32(components[2] * 255.0)

        return UInt(colorAsUInt32)
    }

    /// SS: 获取互补色 (read-only, if applicable).
    var complementary: Color? {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: Color) -> Color?) = { _ -> Color? in
            if self.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = self.cgColor.components
                let components: [CGFloat] = [oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = Color(cgColor: colorRef!)
                return colorOut
            } else {
                return self
            }
        }

        let color = convertColorToRGBSpace(self)
        guard let componentColors = color?.cgColor.components else { return nil }

        let red: CGFloat = sqrt(pow(255.0, 2.0) - pow(componentColors[0] * 255, 2.0)) / 255
        let green: CGFloat = sqrt(pow(255.0, 2.0) - pow(componentColors[1] * 255, 2.0)) / 255
        let blue: CGFloat = sqrt(pow(255.0, 2.0) - pow(componentColors[2] * 255, 2.0)) / 255

        return Color(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// MARK: - Methods

public extension Color {
    /// SS: Blend two Colors
    ///
    /// - Parameters:
    ///   - color1: first color to blend
    ///   - intensity1: intensity of first color (default is 0.5)
    ///   - color2: second color to blend
    ///   - intensity2: intensity of second color (default is 0.5)
    /// - Returns: Color created by blending first and seond colors.
    static func blend(_ color1: Color, intensity1: CGFloat = 0.5, with color2: Color,
                      intensity2: CGFloat = 0.5) -> Color {
        // http://stackoverflow.com/questions/27342715/blend-uicolors-in-swift

        let total = intensity1 + intensity2
        let level1 = intensity1 / total
        let level2 = intensity2 / total

        guard level1 > 0 else { return color2 }
        guard level2 > 0 else { return color1 }

        let components1: [CGFloat] = {
            let comps: [CGFloat] = color1.cgColor.components!
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()

        let components2: [CGFloat] = {
            let comps: [CGFloat] = color2.cgColor.components!
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()

        let red1 = components1[0]
        let red2 = components2[0]

        let green1 = components1[1]
        let green2 = components2[1]

        let blue1 = components1[2]
        let blue2 = components2[2]

        let alpha1 = color1.cgColor.alpha
        let alpha2 = color2.cgColor.alpha

        let red = level1 * red1 + level2 * red2
        let green = level1 * green1 + level2 * green2
        let blue = level1 * blue1 + level2 * blue2
        let alpha = level1 * alpha1 + level2 * alpha2

        return Color(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// SS: 颜色变轻（想白色靠拢）
    ///
    ///     let color = Color(red: r, green: g, blue: b, alpha: a)
    ///     let lighterColor: Color = color.lighten(by: 0.2)
    ///
    /// - Parameter percentage: 比例
    /// - Returns: 变换后的颜色
    func lighten(by percentage: CGFloat = 0.2) -> Color {
        // https://stackoverflow.com/questions/38435308/swift-get-lighter-and-darker-color-variations-for-a-given-uicolor
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return Color(red: min(red + percentage, 1.0),
                     green: min(green + percentage, 1.0),
                     blue: min(blue + percentage, 1.0),
                     alpha: alpha)
    }

    /// SS: 颜色加深
    ///
    ///     let color = Color(red: r, green: g, blue: b, alpha: a)
    ///     let darkerColor: Color = color.darken(by: 0.2)
    ///
    /// - Parameter percentage: 加深比例
    /// - Returns: 加深后的颜色
    func darken(by percentage: CGFloat = 0.2) -> Color {
        // https://stackoverflow.com/questions/38435308/swift-get-lighter-and-darker-color-variations-for-a-given-uicolor
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return Color(red: max(red - percentage, 0),
                     green: max(green - percentage, 0),
                     blue: max(blue - percentage, 0),
                     alpha: alpha)
    }
}

// MARK: - Initializers

public extension Color {
    /// SS: Create Color from RGB values with optional transparency.
    ///
    /// - Parameters:
    ///   - red: 0...255.
    ///   - green: 0...255.
    ///   - blue: 0...255.
    ///   - transparency: 透明度 0 - 1 (默认 1)。
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0, red <= 255 else { return nil }
        guard green >= 0, green <= 255 else { return nil }
        guard blue >= 0, blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }

    /// SS: 根据十六进制生成颜色
    ///
    /// - Parameters:
    ///   - hex: 16进制的值 (例: 0xDECEB5)。
    ///   - transparency: 透明度 0 - 1 (默认 1)。
    convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }

    /// SS: 根据十六进制字符串生成颜色
    ///
    ///     debug 模式下会，无效的 hex，返回默认颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串 (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - transparency: 透明度 0 - 1 (默认 1)。
    ///
    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string = hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xFF
        let green = (hexValue >> 8) & 0xFF
        let blue = hexValue & 0xFF
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }

    /// SS: 生成给定颜色的反色
    ///
    /// - Parameter color: 需要相反颜色的颜色
    convenience init?(complementaryFor color: Color) {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: Color) -> Color?) = { color -> Color? in
            if color.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = color.cgColor.components
                let components: [CGFloat] = [oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = Color(cgColor: colorRef!)
                return colorOut
            } else {
                return color
            }
        }

        let color = convertColorToRGBSpace(color)
        guard let componentColors = color?.cgColor.components else { return nil }

        let red: CGFloat = sqrt(pow(255.0, 2.0) - pow(componentColors[0] * 255, 2.0)) / 255
        let green: CGFloat = sqrt(pow(255.0, 2.0) - pow(componentColors[1] * 255, 2.0)) / 255
        let blue: CGFloat = sqrt(pow(255.0, 2.0) - pow(componentColors[2] * 255, 2.0)) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#endif
