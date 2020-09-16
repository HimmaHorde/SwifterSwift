// UIDatePickerExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Properties

public extension UIDatePicker {
    #if !targetEnvironment(macCatalyst)
    /// SS: UIDatePicker 的文字颜色.
    var textColor: UIColor? {
        get {
            value(forKeyPath: "textColor") as? UIColor
        }
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
    }
    #endif
}

#endif
