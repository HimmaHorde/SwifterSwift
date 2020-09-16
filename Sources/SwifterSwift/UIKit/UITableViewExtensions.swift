// UITableViewExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties

public extension UITableView {
    /// SS: 最后一个 row 的 indexpath.
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else { return nil }
        return indexPathForLastRow(inSection: lastSection)
    }

    /// SS: 最后一个 section 的 index
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
}

// MARK: - Methods

public extension UITableView {
    /// SS: tableView 全部 row 的个数。
    ///
    /// - Returns: 全部 row 的个数。
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }

    /// SS: 获取指定 Section 的最后一个 Cell 的 indexPath
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0 else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }

    /// SS: 带有结束回调事件的刷新方法
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    /// SS: Remove TableFooterView.
    func removeTableFooterView() {
        tableFooterView = nil
    }

    /// SS: Remove TableHeaderView.
    func removeTableHeaderView() {
        tableHeaderView = nil
    }

    /// SS: 根据类名复用UITableViewCell
    ///
    /// - Parameter name: UITableViewCell 类型
    /// - Returns: UITableViewCell 实例.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    /// SS: 根据类名复用UITableViewCell
    ///
    /// - Parameters:
    ///   - name: UITableViewCell 类名.
    ///   - indexPath: 位置
    /// - Returns: UITableViewCell 实例.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    /// SS: 复用 UITableViewHeaderFooterView
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    /// - Returns: UITableViewHeaderFooterView object with associated class name.
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError(
                "Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }

    /// SS: 使用 nib 注册 UITableViewHeaderFooterView
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the header or footer view.
    ///   - name: UITableViewHeaderFooterView type.
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// SS: 使用 Class 注册 UITableViewHeaderFooterView
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// SS: 使用 xib 注册 UITableViewCell
    ///
    ///     Identifier = CLassName
    ///
    /// - Parameters:
    ///   - nib: nib 文件.
    ///   - name: UITableViewCell 类名.
    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }

    /// SS: 批量注册同一个 bundle 下的 nib。
    ///
    ///     适用于 nib 和 Class 名称相同的 Cell
    ///
    /// - Parameters:
    ///   - names: cell 类型数组
    ///   - bundleClass: bundle类名
    func register(nibWithClasses classes: UITableViewCell.Type..., at bundleClass: AnyClass? = nil) {
        register(nibWithClasses: classes, at: bundleClass)
    }

    /// SS: 批量注册同一个 bundle 下的 nib。
    ///
    ///     适用于 nib 和 Class 名称相同的 Cell
    ///
    /// - Parameters:
    ///   - names: cell 类型数组
    ///   - bundleClass: bundle类名
    func register(nibWithClasses classes: [UITableViewCell.Type], at bundleClass: AnyClass? = nil) {
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        for cellType in classes {
            let identifier = String(describing: cellType)
            register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
        }
    }

    /// SS: 批量注册 Cell
    ///
    /// - Parameter names: cell 类型数组
    func register(cellWithClasses classes: UITableViewCell.Type...) {
        register(cellWithClasses: classes)
    }

    /// SS: 批量注册 Cell
    ///
    /// - Parameter names: cell 类型数组
    func register(cellWithClasses classes: [UITableViewCell.Type]) {
        for cellType in classes {
            register(cellType, forCellReuseIdentifier: String(describing: cellType))
        }
    }

    /// SS: 检查IndexPath在tableView中是否有效
    ///
    /// - Parameter indexPath: 要检查的IndexPath
    /// - Returns: 返回是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.row >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.row < numberOfRows(inSection: indexPath.section)
    }

    /// SS: 安全地滚动到可能无效的IndexPath
    ///
    /// - Parameters:
    ///   - indexPath: 目标 indexPath
    ///   - scrollPosition: 位置 上 中 下
    ///   - animated: 是否有动画
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}
#endif
