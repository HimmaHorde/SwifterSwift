//
//  UIStackViewExtensions.swift
//  SwifterSwift-iOS
//
//  Created by Benjamin Meyer on 2/18/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Initializers
@available(iOS 9.0, *)
public extension UIStackView {

    /// 使用 View 数组和其他参数初始化。
    ///
    ///     let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - axis: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views.(default: 0.0)
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis. (default: .fill)
    ///   - distribution: The distribution of the arranged views along the stack view’s axis.(default: .fill)
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 0.0,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }

    /// 批量添加 arrangedSubviews
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

    /// 移除所有ArrangedSubviews
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }

}
#endif
