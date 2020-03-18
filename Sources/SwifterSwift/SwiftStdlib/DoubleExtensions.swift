//
//  DoubleExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: - Properties
public extension Double {

    /// SS: 转换为 Int
    var int: Int {
        return Int(self)
    }

    /// SS: 转换为 Float
    var float: Float {
        return Float(self)
    }

    #if canImport(CoreGraphics)
    /// SS: 转换为 CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif

}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// SS: 指数幂
///
/// - Parameters:
///   - lhs: 底数。
///   - rhs: 指数。
/// - Returns: 结果 (example: 4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Double, rhs: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

// swiftlint:disable identifier_name
prefix operator √
/// SS: 二次根号
///
/// - Parameter double: 开根号的数
/// - Returns: 平方根
public prefix func √ (double: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return sqrt(double)
}
// swiftlint:enable identifier_name
