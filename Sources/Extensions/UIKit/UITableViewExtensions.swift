//
//  UITableViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension UITableView {

    /// 最后一个 row 的 indexpath
    var indexPathForLastRow: IndexPath? {
        return indexPathForLastRow(inSection: lastSection)
    }

    /// 最后一个 section 的 index
    var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }

}

// MARK: - Methods
public extension UITableView {

    /// tableView 全部 row 的个数。
    ///
    /// - Returns: 个数
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }

    /// SwifterSwift: IndexPath for last row in section.
    ///
    /// - Parameter section: section to get last row in.
    /// - Returns: optional last indexPath for last row in section (if applicable).
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }

    /// Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    /// SwifterSwift: Remove TableFooterView.
    func removeTableFooterView() {
        tableFooterView = nil
    }

    /// SwifterSwift: Remove TableHeaderView.
    func removeTableHeaderView() {
        tableHeaderView = nil
    }

    /// 滑动到 scrollView 的底部。
    ///
    /// - Parameter animated: 是否开启动画（默认开启）。
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    /// 滑动到 scrollView 的顶部。
    ///
    /// - Parameter animated: 是否开启动画（默认开启）。
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }

    /// 根据类名复用UITableViewCell
    ///
    /// - Parameter name: UITableViewCell 类型
    /// - Returns: UITableViewCell 实例.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

    /// 根据类名复用UITableViewCell
    ///
    /// - Parameters:
    ///   - name: UITableViewCell 类名.
    ///   - indexPath: 位置
    /// - Returns: UITableViewCell 实例.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

    /// 复用 UITableViewHeaderFooterView
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    /// - Returns: UITableViewHeaderFooterView object with associated class name.
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name))")
        }
        return headerFooterView
    }

    /// 使用 nib 注册 UITableViewHeaderFooterView
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the header or footer view.
    ///   - name: UITableViewHeaderFooterView type.
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// 使用 Class 注册 UITableViewHeaderFooterView
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// 注册 UITableViewCell
    ///
    /// Identifier = CLassName
    ///
    /// - Parameter name: UITableViewCell  类型
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    /// 批量注册 Cell
    ///
    /// - Parameter names: cell 类型数组
    func register<T: UITableViewCell>(cellWithClass names: [T.Type]) {
        for cellType in names {
            register(T.self, forCellReuseIdentifier: String(describing: cellType))
        }
    }

    /// 使用 xib 注册 UITableViewCell
    ///
    /// Identifier = CLassName
    ///
    /// - Parameters:
    ///   - nib: nib 文件.
    ///   - name: UITableViewCell 类名.
    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }

    /// 使用 xib 注册 UITableViewCell，仅当 xib 文件名和 ClassName 相同，Identifier = CLassName。
    ///
    /// - Parameters:
    ///   - name: Cell 类型.
    ///   - bundleClass: xib 所在的 bundle.
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }


    /// 批量注册同一个 bundle 下的 nib。
    ///
    /// - Parameters:
    ///   - names: cell 类型数组
    ///   - bundleClass: bundle类名
    func register<T: UITableViewCell>(nibWithCellClass names: [T.Type], at bundleClass: AnyClass? = nil) {
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        for cellType in names {
            let identifier = String(describing: cellType)
            register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
        }
    }

    /// 检查IndexPath在tableView中是否有效
    ///
    /// - Parameter indexPath: 要检查的IndexPath
    /// - Returns: 返回是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }

    /// 安全地滚动到可能无效的IndexPath
    ///
    /// - Parameters:
    ///   - indexPath: Target IndexPath to scroll to
    ///   - scrollPosition: Scroll position
    ///   - animated: Whether to animate or not
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }

}
#endif
