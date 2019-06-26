//
//  CharacterExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Properties
public extension Character {

    /// 检测是否是 Emoji
    ///
    ///        Character("😀").isEmoji -> true
    ///
    var isEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }

    /// 转为数字
    ///
    ///        Character("1").int -> 1
    ///        Character("A").int -> nil
    ///
    var int: Int? {
        return Int(String(self))
    }

    /// 转为 String 类型
    ///
    ///        Character("a").string -> "a"
    ///
    var string: String {
        return String(self)
    }

    /// 返回对应的小写字符
    ///
    ///        Character("A").lowercased -> Character("a")
    ///
    var lowercased: Character {
        return String(self).lowercased().first!
    }

    /// 返回对应的大写字符
    ///
    ///        Character("a").uppercased -> Character("A")
    ///
    var uppercased: Character {
        return String(self).uppercased().first!
    }

}

// MARK: - Methods
public extension Character {

    #if canImport(Foundation)
    /// 随机字符，取大小写字符和数字。
    ///
    ///    Character.random() -> k
    ///
    /// - Returns: A random character.
    static func randomAlphanumeric() -> Character {
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!
    }
    #endif

}

// MARK: - Operators
public extension Character {

    /// 重复 N 次字符，生成字符串。
    ///
    ///        Character("-") * 10 -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: 需要重复的字符。
    ///   - rhs: 重复次数。
    /// - Returns: 生成的字符串
    static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: String(lhs), count: rhs)
    }

    /// 重复 N 次字符，生成字符串。
    ///
    ///        10 * Character("-") -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: 重复次数。
    ///   - rhs: 需要重复的字符。
    /// - Returns: 生成的字符串
    static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: String(rhs), count: lhs)
    }

}
