//
//  SwifterSwift.swift
//  SwifterSwift
//
//  Created by yanglin on 2019/5/27.
//  Copyright © 2019 SwifterSwift
//

// 代码引用自 rxswift，为防止个 rx 冲突已修改名称

public class SwifterSwift<Base> {
    /// SS: 要扩展的基本对象。
    public let base: Base

    /// SS: 使用对象创建扩展
    ///
    /// - parameter base: 对象。
    public init(_ base: Base) {
        self.base = base
    }
}

/// SS: A type that has reactive extensions.
public protocol SwifterCompatible {
    /// SS: Extended type
    associatedtype SwifterSwiftBase

    /// SS: Reactive extensions.
    static var ss: SwifterSwift<SwifterSwiftBase>.Type { get }

    /// SS: Reactive extensions.
    var ss: SwifterSwift<SwifterSwiftBase> { get }
}

public extension SwifterCompatible {
    /// SS: Reactive extensions.
    static var ss: SwifterSwift<Self>.Type {
        return SwifterSwift<Self>.self
    }

    /// SS: Reactive extensions.
    var ss: SwifterSwift<Self> {
        return SwifterSwift(self)
    }
}

 import class Foundation.NSObject

 /// SS:  Extend NSObject with `ss` proxy.
extension NSObject: SwifterCompatible { }
