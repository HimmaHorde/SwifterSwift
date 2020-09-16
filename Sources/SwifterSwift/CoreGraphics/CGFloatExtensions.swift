// CGFloatExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties

public extension CGFloat {
    /// SS: Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(self)
    }

    #if canImport(Foundation)
    /// SS: Ceil of CGFloat value.
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    #endif

    /// SS: Radian value of degree input.
    var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }

    #if canImport(Foundation)
    /// SS: Floor of CGFloat value.
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    #endif

    /// SS: Check if CGFloat is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// SS: Check if CGFloat is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// SS: Int.
    var int: Int {
        return Int(self)
    }

    /// SS: Float.
    var float: Float {
        return Float(self)
    }

    /// SS: Double.
    var double: Double {
        return Double(self)
    }

    /// SS: Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
}

#endif
