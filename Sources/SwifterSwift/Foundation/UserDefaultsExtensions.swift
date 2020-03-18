//
//  UserDefaultsExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/5/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation) && !os(Linux)
import Foundation

// MARK: - Methods
public extension UserDefaults {

    /// SS: 使用下标从UserDefaults获取对象
    ///
    /// - Parameter key: 键
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// SS: Float from UserDefaults.
    ///
    /// - Parameter forKey: key to find float for.
    /// - Returns: Float object for key (if exists).
    func float(forKey key: String) -> Float? {
        return object(forKey: key) as? Float
    }

    /// SS: Date from UserDefaults.
    ///
    /// - Parameter forKey: key to find date for.
    /// - Returns: Date object for key (if exists).
    func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }

    /// SS: UserDefaults获取对象并进行JSON解析
    ///
    /// - Parameters:
    ///   - type: 遵守 Codable 协议的类型
    ///   - key: 对象的键
    ///   - decoder: 解码器
    /// - Returns: 解码后的值 (if exists).
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    /// SS: 将可编码对象，编码后放入UserDefaults。
    ///
    /// - Parameters:
    ///   - object: 要保存的源对象
    ///   - key: 保存时的键
    ///   - encoder: 编码器（默认 `JSONEncoder()`）
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }

}

#endif
