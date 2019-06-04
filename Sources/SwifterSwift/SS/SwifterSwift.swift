//
//  SwifterSwift.swift
//  SwifterSwift
//
//  Created by yanglin on 2019/5/27.
//  Copyright © 2019 SwifterSwift
//

// 代码引用自 rxswift，为防止个 rx 冲突已修改名称

public struct SwifterSwift<Base> {
    /// 要扩展的基本对象。
    public let base: Base

    /// 使用对象创建扩展
    ///
    /// - parameter base: 对象。
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has reactive extensions.
public protocol SwifterCompatible {
    /// Extended type
    associatedtype ReactiveBase

    /// Reactive extensions.
    static var ss: SwifterSwift<ReactiveBase>.Type { get set }

    /// Reactive extensions.
    var ss: SwifterSwift<ReactiveBase> { get set }
}

extension SwifterCompatible {
    /// Reactive extensions.
    public static var ss: SwifterSwift<Self>.Type {
        get {
            return SwifterSwift<Self>.self
        }
        set {
            // this enables using Reactive to "mutate" base type
        }
    }

    /// Reactive extensions.
    public var ss: SwifterSwift<Self> {
        get {
            return SwifterSwift(self)
        }
        set {
            // this enables using Reactive to "mutate" base object
        }
    }
}

import class Foundation.NSObject

/// Extend NSObject with `ss` proxy.
extension NSObject: SwifterCompatible { }
