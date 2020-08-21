//
//  UIDatePickerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 12/9/17.
//  Copyright © 2017 SwifterSwift
//

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
