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

    /// SS: 返回当前队列是否是主队列
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

    /// SS: 返回 bool 类型,判断当前队列是否是指定队列.
    ///
    /// - Parameter queue: 要比较的队列.
    /// - Returns: 是指定队列返回`true`,否则返回`false`.
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }

    /// SS: Runs passed closure asynchronous after certain time interval
    ///
    /// - Parameters:
    ///   - delay: The time inverval after which the closure will run.
    ///   - qos: Quality of service at which the work item should be executed.
    ///   - flags: Flags that control the execution environment of the work item.
    ///   - work: The closure to run after certain time interval.
    func asyncAfter(delay: Double,
                    qos: DispatchQoS = .unspecified,
                    flags: DispatchWorkItemFlags = [],
                    execute work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, qos: qos, flags: flags, execute: work)
    }

    func debounce(delay: Double, action: @escaping () -> Void) -> () -> Void {
        // http://stackoverflow.com/questions/27116684/how-can-i-debounce-a-method-call
        var lastFireTime = DispatchTime.now()
        let deadline = { lastFireTime + delay }
        return {
            self.asyncAfter(deadline: deadline()) {
                let now = DispatchTime.now()
                if now >= deadline() {
                    lastFireTime = now
                    action()
                }
            }
        }
    }

}

#endif
