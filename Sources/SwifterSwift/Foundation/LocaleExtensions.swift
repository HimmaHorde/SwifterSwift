//
//  LocalExtensions.swift
//  SwifterSwift
//
//  Created by Basem Emara on 4/19/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Locale {

    /// 通常用于规范化的语言环境的UNIX表示。
    static var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }

    /// ss: 返回bool值，指示语言环境是否具有12h格式。
    var is12HourTimeFormat: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = self
        let dateString = dateFormatter.string(from: Date())
        return dateString.contains(dateFormatter.amSymbol) || dateString.contains(dateFormatter.pmSymbol)
    }
}
#endif
