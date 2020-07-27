//
//  UITextFieldExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Enums
public extension UITextField {

    /// SS: UITextField text type.
    ///
    /// - emailAddress: UITextField is used to enter email addresses.
    /// - password: UITextField is used to enter passwords.
    /// - generic: UITextField is used to enter generic text.
    enum TextType {
        /// SS: UITextField is used to enter email addresses.
        case emailAddress

        /// SS: UITextField is used to enter passwords.
        case password

        /// SS: UITextField is used to enter generic text.
        case generic
    }

}

// MARK: - Properties
public extension UITextField {

    /// SS: Set textField for common text types.
    var textType: TextType {
        get {
            if keyboardType == .emailAddress {
                return .emailAddress
            } else if isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                keyboardType = .emailAddress
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = false
                if placeholder?.isEmpty != false {
                    placeholder = "Email Address"
                }
            case .password:
                keyboardType = .asciiCapable
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = true
                if placeholder?.isEmpty != false {
                    placeholder = "Password"
                }
            case .generic:
                isSecureTextEntry = false
            }
        }
    }

    /// SS: 文字是否为空
    var isEmpty: Bool {
        return text?.isEmpty == true
    }

    /// SS: 去除 text 头尾的空格和换行
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// SS: 检测是否是有效的 Mail
    ///
    ///		textField.text = "john@doe.com"
    ///		textField.hasValidEmail -> true
    ///
    ///		textField.text = "swifterswift"
    ///		textField.hasValidEmail -> false
    ///
    var hasValidEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }

    /// SS: Left view tint color.
    @IBInspectable var leftViewTintColor: UIColor? {
        get {
            guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }

    /// SS: Right view tint color.
    @IBInspectable var rightViewTintColor: UIColor? {
        get {
            guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = rightView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }

}

// MARK: - Methods
public extension UITextField {

    /// SS: 清除 text
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// SS: 设置占位文字颜色
    ///
    /// - Parameter color: 颜色
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    /// SS: 在左侧添加一个空白的 view
    ///
    /// - Parameter padding: 左侧边距.
    func addPaddingLeft(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
    }

    /// SS: Add padding to the right of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the right of the textfield rect.
    func addPaddingRight(_ padding: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }

    /// SS: Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        leftView = iconView
        leftViewMode = .always
    }

    /// SS: Add padding to the right of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: right image
    ///   - padding: amount of padding between icon and the right of textfield
    func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        rightView = iconView
        rightViewMode = .always
    }

}

#endif
