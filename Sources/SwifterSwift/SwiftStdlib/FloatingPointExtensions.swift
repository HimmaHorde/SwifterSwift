//
//  FloatingPointExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 7/23/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension FloatingPoint {

    /// SS: 绝对值
    var abs: Self {
        return Swift.abs(self)
    }

    #if canImport(Foundation)
    /// SS: 向上取整
    var ceil: Self {
        return Foundation.ceil(self)
    }

    /// SS: 向下取整
    var floor: Self {
        return Foundation.floor(self)
    }
    #endif

    /// SS: 圆心角 -> 圆心角弧度数
    var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }

    /// SS: 圆心角弧度数 -> 圆心角
    var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }

}

// MARK: - Operators
infix operator ±
/// SS: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: number
///   - rhs: number
/// - Returns: tuple of plus-minus operation ( 2.5 ± 1.5 -> (4, 1)).
// swiftlint:disable:next identifier_name
public func ± <T: FloatingPoint> (lhs: T, rhs: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return (lhs + rhs, lhs - rhs)
}

prefix operator ±
/// SS: Tuple of plus-minus operation.
///
/// - Parameter int: number
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
// swiftlint:disable:next identifier_name
public prefix func ± <T: FloatingPoint> (number: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return 0 ± number
}

// swiftlint:disable identifier_name
prefix operator √
/// SS: Square root of float.
///
/// - Parameter float: float value to find square root for
/// - Returns: square root of given float.
public prefix func √<T> (float: T) -> T where T: FloatingPoint {
    // http://nshipster.com/swift-operators/
    return sqrt(float)
}
// swiftlint:enable identifier_name
