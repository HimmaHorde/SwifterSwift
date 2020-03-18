//
//  UISwitchExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 08/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)  && os(iOS)
import UIKit

// MARK: - Methods
public extension UISwitch {

    /// SS: 切换开关
    ///
    /// - Parameter animated: 是否具有动画效果（默认 true）
    func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }

}

#endif
