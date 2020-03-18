//
//  UICollectionViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 11/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension UICollectionView {

    /// SS: 获取 CollectionView 最后一个元素.
    var indexPathForLastItem: IndexPath? {
        return indexPathForLastItem(inSection: lastSection)
    }

    /// SS: 获取最后一个 section 的index.
    var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }

}

// MARK: - Methods
public extension UICollectionView {

    /// SS: 获取 collectionView 里面的 cell 总和.
    ///
    /// - Returns: collectionView rows 的计数.
    func numberOfItems() -> Int {
        var section = 0
        var itemsCount = 0
        while section < numberOfSections {
            itemsCount += numberOfItems(inSection: section)
            section += 1
        }
        return itemsCount
    }

    /// SS: 获取指定 section 里面最后一个 cell 的 IndexPath.
    ///
    /// - Parameter section: 指定 collectionView 的 section.
    /// - Returns: 返回 indexpath?
    func indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard section < numberOfSections else {
            return nil
        }
        guard numberOfItems(inSection: section) > 0 else {
            return IndexPath(item: 0, section: section)
        }
        return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }

    /// SS: 刷新数据源,并添加结束回调
    ///
    /// - Parameter completion: reloadData 结束后的回调.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    /// SS: cell 根据类名复用.
    ///
    /// - Parameters:
    ///   - name: UICollectionViewCell 类型.
    ///   - indexPath: cell 在 collectionView 中的位置.
    /// - Returns: UICollectionViewCell 对象.
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name)), make sure the cell is registered with collection view")
        }
        return cell
    }

    /// SS: UICollectionReusableView 根据类名复用.
    ///
    /// - Parameters:
    ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - name: 类型 UICollectionElementKindSectionHeader.
    ///   - indexPath: location of cell in collectionView.
    /// - Returns: UICollectionReusableView object with associated class name.
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: name)), make sure the view is registered with collection view")
        }
        return cell
    }

    /// SS: Register UICollectionReusableView using class name.
    ///
    /// - Parameters:
    ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - name: UICollectionReusableView type.
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }

    /// SS: Register UICollectionViewCell using class name.
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the collectionView cell.
    ///   - name: UICollectionViewCell type.
    func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
        register(nib, forCellWithReuseIdentifier: String(describing: name))
    }

    /// SS: Register UICollectionReusableView using class name.
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the reusable view.
    ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - name: UICollectionReusableView type.
    func register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }

    /// SS: 批量注册 cell
    func register(cellWithClasses classes: [UICollectionViewCell.Type]) {
        for cellType in classes {
            register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
        }
    }

    /// SS: 批量注册 cell
    func register(cellWithClasses classes: UICollectionViewCell.Type...) {
        register(cellWithClasses: classes)
    }

    /// SS: 批量注册 nib cell，默认 xib 文件在 mainBundle 中。
    func register(nibWithCellClasses classes: UICollectionViewCell.Type..., at bundleClass: AnyClass? = nil) {
        register(nibWithCellClasses: classes, at: bundleClass)
    }

    /// SS: 批量注册 nib cell，默认 xib 文件在 mainBundle 中。
    func register(nibWithCellClasses classes: [UICollectionViewCell.Type], at bundleClass: AnyClass? = nil) {
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        for cellType in classes {
            let identifier = String(describing: cellType)
            register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
        }
    }

    /// SS: Safely scroll to possibly invalid IndexPath
    ///
    /// - Parameters:
    ///   - indexPath: Target IndexPath to scroll to
    ///   - scrollPosition: Scroll position
    ///   - animated: Whether to animate or not
    func safeScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard indexPath.item >= 0 &&
            indexPath.section >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.item < numberOfItems(inSection: indexPath.section) else {
                return
        }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }

    /// SS: Check whether IndexPath is valid within the CollectionView
    ///
    /// - Parameter indexPath: An IndexPath to check
    /// - Returns: Boolean value for valid or invalid IndexPath
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.item >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.item < numberOfItems(inSection: indexPath.section)
    }

}

#endif
