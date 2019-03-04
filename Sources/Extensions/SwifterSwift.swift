//
//  SwifterSwift.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)
import UIKit
#endif

#if canImport(WatchKit)
import WatchKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

#if !os(Linux)
// MARK: - Properties
/// 常用的属性和方法。
public struct SwifterSwift {

    #if !os(macOS)
    /// App 名称 (如果存在)
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
    #endif

    #if !os(macOS)
    /// bundle ID (如果存在).
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    #endif

    #if os(iOS)
    /// 状态栏高度
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    #endif

    #if !os(macOS)
    /// App当前构建版本号 (如果存在).
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// APP 角标数
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    #endif

    #if !os(macOS)
    /// APP 当前的版本号 (如果存在).
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    #endif

    #if os(iOS)
    /// 当前的电池电量
    public static var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 当前设备的共享实例
    public static var currentDevice: UIDevice {
        return UIDevice.current
    }
    #elseif os(watchOS)
    /// 当前设备的共享实例
    public static var currentDevice: WKInterfaceDevice {
        return WKInterfaceDevice.current()
    }
    #endif

    #if !os(macOS)
    /// 当前的设备模型 (eg. @”iPhone” , @”iPod touch”).
    public static var deviceModel: String {
        return currentDevice.model
    }
    #endif

    #if !os(macOS)
    /// 当前设备名称
    public static var deviceName: String {
        return currentDevice.name
    }
    #endif

    #if os(iOS)
    /// 设备当前方向。
    public static var deviceOrientation: UIDeviceOrientation {
        return currentDevice.orientation
    }
    #endif

    #if !os(macOS)
    /// 屏幕高度
    public static var screenHeight: CGFloat {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.height
        #elseif os(watchOS)
        return currentDevice.screenBounds.height
        #endif
    }
    #endif

    #if !os(macOS)
    /// 屏幕宽度
    public static var screenWidth: CGFloat {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.width
        #elseif os(watchOS)
        return currentDevice.screenBounds.width
        #endif
    }
    #endif

    /// 是否是 debug 模式
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    #if !os(macOS)
    /// 是否是TestFlightn模式
    public static var isInTestFlight: Bool {
        // http://stackoverflow.com/questions/12431994/detect-testflight
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }
    #endif

    #if os(iOS)
    /// 前设备是否支持多任务处理。
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    #endif

    #if os(iOS)
    /// 打开或关闭网络活动的指示器。
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    #endif

    #if os(iOS)
    /// 检查设备是否是iPad。
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    #endif

    #if os(iOS)
    /// 检查设备是否是iPhone。
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 检查当前 APP 是否注册远程推送 (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    #endif

    /// 检查应用程序是否在模拟器上运行 (read-only).
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    #if os(iOS)
    /// 状态栏是否可见
    public static var isStatusBarHidden: Bool {
        get {
            return UIApplication.shared.isStatusBarHidden
        }
        set {
            UIApplication.shared.isStatusBarHidden = newValue
        }
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// Key window (read only, 如果存在).
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 最顶层视图控制器 (如果存在).
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// UIApplication 实例
    public static var sharedApplication: UIApplication {
        return UIApplication.shared
    }
    #endif

    #if os(iOS)
    /// 当前状态栏样式 (如果存在).
    public static var statusBarStyle: UIStatusBarStyle? {
        get {
            return UIApplication.shared.statusBarStyle
        }
        set {
            if let style = newValue {
                UIApplication.shared.statusBarStyle = style
            }
        }
    }
    #endif

    #if !os(macOS)
    /// 系统当前版本号 (read-only).
    public static var systemVersion: String {
        return currentDevice.systemVersion
    }
    #endif

}

// MARK: - Methods
public extension SwifterSwift {

    /// 延迟调用函数或闭包
    ///
    /// - Parameters:
    ///   - milliseconds: 延迟时间 (单位：毫秒)。
    ///   - queue: 完成闭包所在的队列。
    ///   - completion: 延迟后执行的闭包。
    ///   - Returns: DispatchWorkItem任务。您可以调用.cancel()来取消延迟的执行。
    @discardableResult static func delay(milliseconds: Double, queue: DispatchQueue = .main, completion: @escaping () -> Void) -> DispatchWorkItem {
        let task = DispatchWorkItem { completion() }
        queue.asyncAfter(deadline: .now() + (milliseconds/1000), execute: task)
        return task
    }

    /// 取消函数或闭包调用
    ///
    /// - Parameters:
    ///   - millisecondsOffset: allow execution of method if it was not called since millisecondsOffset.
    ///   - queue: a queue that action closure should be executed on (default is DispatchQueue.main).
    ///   - action: closure to be executed in a debounced way.
    static func debounce(millisecondsDelay: Int, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        // http://stackoverflow.com/questions/27116684/how-can-i-debounce-a-method-call
        var lastFireTime = DispatchTime.now()
        let dispatchDelay = DispatchTimeInterval.milliseconds(millisecondsDelay)
        let dispatchTime: DispatchTime = lastFireTime + dispatchDelay
        return {
            queue.asyncAfter(deadline: dispatchTime) {
                let when: DispatchTime = lastFireTime + dispatchDelay
                let now = DispatchTime.now()
                if now.rawValue >= when.rawValue {
                    lastFireTime = DispatchTime.now()
                    action()
                }
            }
        }
    }

    #if os(iOS) || os(tvOS)
    /// SwifterSwift: Called when user takes a screenshot
    ///
    /// - Parameter action: a closure to run when user takes a screenshot
    static func didTakeScreenShot(_ action: @escaping (_ notification: Notification) -> Void) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification,
                                                   object: nil,
                                                   queue: OperationQueue.main) { notification in
                                                    action(notification)
        }
    }
    #endif

    /// 对象的类名
    ///
    /// - Parameter object: 任意实例对象
    /// - Returns: 对象的类型字符串
    static func typeName(for object: Any) -> String {
        let objectType = type(of: object.self)
        return String.init(describing: objectType)
    }

}

// swiftlint:disable next type_name
public typealias SS = SwifterSwift

#endif
