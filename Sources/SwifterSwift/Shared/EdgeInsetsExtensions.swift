//
//  EdgeInsetsExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 03/01/2020.
//  Copyright © 2020 SwifterSwift
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
/// SS: EdgeInsets
public typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import Foundation
/// SS: EdgeInsets
public typealias EdgeInsets = NSEdgeInsets

public extension NSEdgeInsets {
    /// SS: 上右下左都是0的`EdgeInsets`.
    static let zero = NSEdgeInsets()
}

extension NSEdgeInsets: Equatable {
    /// SS: 返回一个判断两个`EdgeInsets`是否相等布尔值.
    ///
    ///     Equality is the inverse of inequality. For any values `a` and `b`,
    ///     `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {
        return lhs.top == rhs.top &&
            lhs.left == rhs.left &&
            lhs.bottom == rhs.bottom &&
            lhs.right == rhs.right
    }
}
#endif

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)

// MARK: - Properties
public extension EdgeInsets {
    /// SS: 返回垂直insets。由top+bottom组成。
    ///
    var vertical: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return top + bottom
    }

    /// SS: 返回水平的insets。由 left + right 组成。
    ///
    var horizontal: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return left + right
    }

}

// MARK: - Methods
public extension EdgeInsets {
    /// SS: 创建一个所有边距都等于给定值的`EdgeInsets`.
    ///
    /// - Parameter inset: 应用到所有边距的值.
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// SS: Creates an `EdgeInsets` with the horizontal value equally divided and applied to right and left.
    ///               And the vertical value equally divided and applied to top and bottom.
    ///
    ///
    /// - Parameter horizontal: Inset to be applied to right and left.
    /// - Parameter vertical: Inset to be applied to top and bottom.
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical / 2, left: horizontal / 2, bottom: vertical / 2, right: horizontal / 2)
    }

    /// SS: 创建一个新的`EdgeInsets`,top值为当前值加上偏移量.
    ///
    /// - Parameters:
    ///   - top: top的偏移量
    /// - Returns: 偏移处理后的`EdgeInsets`
    func insetBy(top: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: self.top + top, left: left, bottom: bottom, right: right)
    }

    /// SS: 创建一个新的`EdgeInsets`,left值为当前值加上偏移量.
    ///
    /// - Parameters:
    ///   - left: 左的偏移量
    /// - Returns: 偏移处理后的`EdgeInsets`
    func insetBy(left: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: self.left + left, bottom: bottom, right: right)
    }

    /// SS: 创建一个新的`EdgeInsets`,bottom值为当前值加上偏移量.
    ///
    /// - Parameters:
    ///   - bottom: 下边距的偏移量
    /// - Returns: 偏移处理后的`EdgeInsets`
    func insetBy(bottom: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: left, bottom: self.bottom + bottom, right: right)
    }

    /// SS: 创建一个新的`EdgeInsets`,right值为当前值加上偏移量.
    ///
    /// - Parameters:
    ///   - right: 右边距的偏移量
    /// - Returns: 偏移处理后的`EdgeInsets`
    func insetBy(right: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: left, bottom: bottom, right: self.right + right)
    }

    /// SS: Creates an `EdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to right and left.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(horizontal: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: left + horizontal / 2, bottom: bottom, right: right + horizontal / 2)
    }

    /// SS: Creates an `EdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(vertical: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top + vertical / 2, left: left, bottom: bottom + vertical / 2, right: right)
    }
}

// MARK: - Operators
public extension EdgeInsets {

    /// SS: 返回一个新的`EdgeInsets`,其属性为两个`EdgeInsets`的所有属性相加.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression
    ///   - rhs: The right-hand expression
    /// - Returns: A new `EdgeInsets` instance where the values of `lhs` and `rhs` are added together.
    static func + (_ lhs: EdgeInsets, _ rhs: EdgeInsets) -> EdgeInsets {
        return EdgeInsets(top: lhs.top + rhs.top,
                            left: lhs.left + rhs.left,
                            bottom: lhs.bottom + rhs.bottom,
                            right: lhs.right + rhs.right)
    }

    /// SS: 将两个`EdgeInsets`的所有属性相加赋值给左边的`EdgeInsets` .
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression to be mutated
    ///   - rhs: The right-hand expression
    static func += (_ lhs: inout EdgeInsets, _ rhs: EdgeInsets) {
        lhs.top += rhs.top
        lhs.left += rhs.left
        lhs.bottom += rhs.bottom
        lhs.right += rhs.right
    }

}

#endif
