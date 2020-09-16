// DoubleExtensions.swift - Copyright 2020 SwifterSwift

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
    /// SS: Int.
    var int: Int {
        return Int(self)
    }

    /// SS: Float.
    var float: Float {
        return Float(self)
    }

    #if canImport(CoreGraphics)
    /// SS: CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence
/// SS: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Double, rhs: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}
