//
//  FloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// MARK: - Properties
public extension Float {

    /// 转换为 Int.
    var int: Int {
        return Int(self)
    }

    /// 转换为 Double.
    var double: Double {
        return Double(self)
    }

    #if canImport(CoreGraphics)
    /// 转换为 CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif

}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// 指数幂
///
/// - Parameters:
///   - lhs: 底数
///   - rhs: 指数
/// - Returns: 结果 (4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Float, rhs: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

// swiftlint:disable next identifier_name
prefix operator √
/// 二次根号
///
/// - Parameter float: 开根号的数
/// - Returns: 平分跟
public prefix func √ (float: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return sqrt(float)
}
