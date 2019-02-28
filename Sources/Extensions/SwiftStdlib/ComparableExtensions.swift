//
//  ComparableExtensions.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 5/4/18.
//  Copyright © 2018 SwifterSwift
//

// MARK: - Methods
public extension Comparable {

    /// 判断元素是否在闭区间内。
    ///
    /// - Parameters:
    ///   - value: 元素值。
    ///   - pattern: 闭区间。
    /// - Returns: 在返回 true，否则 false。
    static func ~= (value: Self, pattern: ClosedRange<Self>) -> Bool {
        return pattern ~= value
    }

    /// 值在闭区间内返回self，否则返回闭区间的 Lower 或者 Upper
    ///
    ///     1.clamped(to: 3...8) // 3
    ///     4.clamped(to: 3...7) // 4
    ///     "c".clamped(to: "e"..."g") // "e"
    ///     0.32.clamped(to: 0.1...0.29) // 0.29
    ///
    /// - parameter min: Lower bound to limit the value to.
    /// - parameter max: Upper bound to limit the value to.
    ///
    /// - returns: A value limited to the range between `min` and `max`.
    func clamped(to range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(self, range.upperBound))
    }

}
