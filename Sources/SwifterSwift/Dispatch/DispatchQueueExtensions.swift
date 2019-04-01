//
//  DispatchQueueExtensions.swift
//  SwifterSwift
//
//  Created by Quentin Jin on 2018/10/13.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Dispatch)
import Dispatch

// MARK: - 属性
public extension DispatchQueue {

    /// SwifterSwift: 返回当前队列是否是主队列
    static var isMainQueue: Bool {
        enum Static {
            static var key: DispatchSpecificKey<Void> = {
                let key = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: key, value: ())
                return key
            }()
        }
        return DispatchQueue.getSpecific(key: Static.key) != nil
    }

}

// MARK: - 方法
public extension DispatchQueue {

    /// SwifterSwift: 返回 bool 类型,判断当前队列是否是指定队列.
    ///
    /// - Parameter queue: 要比较的队列.
    /// - Returns: 是指定队列返回`true`,否则返回`false`.
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }

}

#endif
