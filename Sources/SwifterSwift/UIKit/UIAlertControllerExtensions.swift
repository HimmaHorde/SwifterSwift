//
//  UIAlertControllerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

#if canImport(AudioToolbox)
import AudioToolbox
#endif

// MARK: - Methods
public extension UIAlertController {

    /// SS: keyWindow 的根视图弹出一个警告框。
    ///
    /// - Parameters:
    ///   - animated: 是否显示动画。
    ///   - vibrate: 是否震动。
    ///   - completion: 结束回调,默认为空。
    func show(animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil) {
        #if targetEnvironment(macCatalyst)
        let window = UIApplication.shared.windows.last
        #else
        let window = UIApplication.shared.keyWindow
        #endif
        window?.rootViewController?.present(self, animated: animated, completion: completion)
        if vibrate {
            #if canImport(AudioToolbox)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            #endif
        }
    }

    /// SS: 为自身添加一个 action 对象
    ///
    /// - Parameters:
    ///   - title: action 的标题
    ///   - style: action 样式 (默认 UIAlertActionStyle.default)
    ///   - isEnabled: 是否可用 (默认 true)
    ///   - handler: 点击回调 (默认 nil)
    /// - Returns: 返回添加的 action
    @discardableResult
    func addAction(title: String, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }

    /// SS: 为自身添加一个文本输入框
    ///
    /// - Parameters:
    ///   - text: 文本框文字 (默认 nil)
    ///   - placeholder: 文本框的占位字符串 (默认 nil)
    ///   - editingChangedTarget: editingChanged 事件的 target(可选)
    ///   - editingChangedSelector: editingChanged 的响应方法(可选)
    func addTextField(text: String? = nil, placeholder: String? = nil, editingChangedTarget: Any?, editingChangedSelector: Selector?) {
        addTextField { textField in
            textField.text = text
            textField.placeholder = placeholder
            if let target = editingChangedTarget, let selector = editingChangedSelector {
                textField.addTarget(target, action: selector, for: .editingChanged)
            }
        }
    }

}

// MARK: - Initializers
public extension UIAlertController {

    /// SS: 创建只有一个确认按钮的提示框.
    ///
    /// - Parameters:
    ///   - title: 标题.
    ///   - message: 消息 (默认 nil).
    ///   - actionTitle: 按钮标题 (默认 "OK")
    ///   - tintColor: alert controller's tint color (默认 nil)
    convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        if let color = tintColor {
            view.tintColor = color
        }
    }

    /// SS: Create new error alert view controller from Error with default OK action.
    ///
    /// - Parameters:
    ///   - title: alert controller's title (默认 "Error").
    ///   - error: error to set alert controller's message to it's localizedDescription.
    ///   - defaultActionButtonTitle: default action button title (默认 "OK")
    ///   - tintColor: alert controller's tint color (默认 nil)
    convenience init(title: String = "Error", error: Error, defaultActionButtonTitle: String = "OK", preferredStyle: UIAlertController.Style = .alert, tintColor: UIColor? = nil) {
        self.init(title: title, message: error.localizedDescription, preferredStyle: preferredStyle)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        if let color = tintColor {
            view.tintColor = color
        }
    }

}

#endif
