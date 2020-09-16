// FloatExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: - Properties

public extension Float {
    /// SS: Int.
    var int: Int {
        return Int(self)
    }

    /// SS: Double.
    var double: Double {
        return Double(self)
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
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Float, rhs: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}
