//
//  DataExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Data {

    /// SS: 以字节数组的形式返回数据
    var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }

}

// MARK: - Methods
public extension Data {

    /// SS: 使用给定编码(如果适用)对数据进行编码。
    ///
    /// - Parameter encoding: 编码
    /// - Returns: 编码后的字符串 (如果适用).
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// SS: JsonData 直接解析
    ///
    /// - Parameter options: 解析选项 JSONSerialization.ReadingOptions
    /// - Returns: 返回一个 Function 对象，如果发生错误，则为“nil”。
    /// - Throws: 抛出解析异常.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }

}

#endif
