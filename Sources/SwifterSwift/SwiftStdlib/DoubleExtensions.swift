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

// MARK: - Properties
public extension Double {

    /// 转换为 Int
    var int: Int {
        return Int(self)
    }

    /// 转换为 Float
    var float: Float {
        return Float(self)
    }

    #if canImport(CoreGraphics)
    /// 转换为 CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif

}

// MARK: - Operators

#if canImport(Foundation) && !os(Linux)

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// 指数幂
///
/// - Parameters:
///   - lhs: 底数。
///   - rhs: 指数。
/// - Returns: 结果 (example: 4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Double, rhs: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

#endif

#if canImport(Foundation) && !os(Linux)

prefix operator √
/// 二次根号
///
/// - Parameter double: 开根号的数
/// - Returns: 平方根
// swiftlint:disable:next identifier_name
public prefix func √ (double: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return sqrt(double)
}

#endif
