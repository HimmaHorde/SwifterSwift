//
//  EdgeInsetsExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 03/01/2020.
//  Copyright © 2020 SwifterSwift
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
/// SwifterSwift: EdgeInsets
public typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import Foundation
/// SwifterSwift: EdgeInsets
public typealias EdgeInsets = NSEdgeInsets

public extension NSEdgeInsets {
    /// ss: 上右下左都是0的 edge insets.
    static let zero = NSEdgeInsets()
}

// swiftlint:disable missing_swifterswift_prefix
extension NSEdgeInsets: Equatable {
    /// 返回一个布尔值表示两个数是否相等.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
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
// swiftlint:enable missing_swifterswift_prefix
#endif

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)

// MARK: - Properties
public extension EdgeInsets {
    /// ss: 返回垂直insets。由top+bottom组成。
    ///
    var vertical: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return top + bottom
    }

    /// ss: 返回水平的insets。由 left + right 组成。
    ///
    var horizontal: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return left + right
    }

}

// MARK: - Methods
public extension EdgeInsets {
    /// SwifterSwift: Creates an `EdgeInsets` with the inset value applied to all (top, bottom, right, left)
    ///
    /// - Parameter inset: Inset to be applied in all the edges.
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// SwifterSwift: Creates an `EdgeInsets` with the horizontal value equally divided and applied to right and left.
    ///               And the vertical value equally divided and applied to top and bottom.
    ///
    ///
    /// - Parameter horizontal: Inset to be applied to right and left.
    /// - Parameter vertical: Inset to be applied to top and bottom.
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical / 2, left: horizontal / 2, bottom: vertical / 2, right: horizontal / 2)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied in to the top edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(top: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: self.top + top, left: left, bottom: bottom, right: right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and left offset.
    ///
    /// - Parameters:
    ///   - left: Offset to be applied in to the left edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(left: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: self.left + left, bottom: bottom, right: right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied in to the bottom edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(bottom: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: left, bottom: self.bottom + bottom, right: right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and right offset.
    ///
    /// - Parameters:
    ///   - right: Offset to be applied in to the right edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(right: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: left, bottom: bottom, right: self.right + right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to right and left.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(horizontal: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: top, left: left + horizontal / 2, bottom: bottom, right: right + horizontal / 2)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
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

    /// SwifterSwift: Add all the properties of two `EdgeInsets` to create their addition.
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

    /// SwifterSwift: Add all the properties of two `EdgeInsets` to the left-hand instance.
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
