// ComparableExtensions.swift - Copyright 2020 SwifterSwift

// MARK: - Methods

public extension Comparable {
    /// SS: 判断元素是否在闭区间内.
    ///
    /// - Parameters:
    ///   - value: 元素值。
    ///   - pattern: 闭区间。
    /// - Returns: 在返回 true，否则 false。
    static func ~= (value: Self, pattern: ClosedRange<Self>) -> Bool {
        return pattern ~= value
    }

    /// SS: 判断元素是否在闭区间内。
    ///    1.isBetween(5...7) // false
    ///    7.isBetween(6...12) // true
    ///    date.isBetween(date1...date2)
    ///    "c".isBetween(a...d) // true
    ///    0.32.isBetween(0.31...0.33) // true
    ///
    /// - parameter min: Minimum comparable value.
    /// - parameter max: Maximum comparable value.
    ///
    /// - returns: `true` if value is between `min` and `max`, `false` otherwise.
    func isBetween(_ range: ClosedRange<Self>) -> Bool {
        return range ~= self
    }

    /// SS: 值在闭区间内返回self，否则返回闭区间的 Lower 或者 Upper
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
