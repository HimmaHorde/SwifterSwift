//
//  DateFormatterExtensions.swift
//  SwifterSwift
//
//  Created by yanglin on 2019/6/26.
//  Copyright © 2019 SwifterSwift
//
#if canImport(Foundation)
import Foundation

// MARK: init
extension DateFormatter {
    // 使用指定 format 初始化
    public static func initWith(format: String) -> DateFormatter {
        let instance = self.init()
        instance.dateFormat = format
        return instance
    }
}

#endif
