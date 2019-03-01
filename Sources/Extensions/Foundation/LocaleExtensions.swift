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
    var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }

}
#endif
