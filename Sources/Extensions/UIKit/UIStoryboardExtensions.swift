//
//  UIStoryboardExtensions.swift
//  SwifterSwift
//
//  Created by Steven on 2/6/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(UIKit)  && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIStoryboard {

    /// 获取 Main
    static var main: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }

    /// 获取 ViewController 实例，类名作为Identifier
    ///
    /// - Parameter name: UIViewController 类型
    /// - Returns: The view controller corresponding to specified class name
    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }

}
#endif
