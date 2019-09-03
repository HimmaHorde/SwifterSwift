//
//  ArrayExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Methods
public extension Array {

    /// 在数组的开头插入一个元素
    ///
    ///     [2, 3, 4, 5].prepend(1) -> [1, 2, 3, 4, 5]
    ///     ["e", "l", "l", "o"].prepend("h") -> ["h", "e", "l", "l", "o"]
    ///
    /// - Parameter newElement: 要插入的元素
    mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }

    /// 安全交换两个位置的值
    ///
    ///        [1, 2, 3, 4, 5].safeSwap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
    ///        ["h", "e", "l", "l", "o"].safeSwap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
    ///
    /// - Parameters:
    ///   - i: index of first element.
    ///   - j: index of other element.
    mutating func safeSwap(_ i: Index, _ j: Index) {
        guard i != j else { return }
        guard startIndex..<endIndex ~= i else {
            assertionFailure("左侧越界")
            return }
        guard startIndex..<endIndex ~= j else {
            assertionFailure("右侧越界")
            return }
        swapAt(i, j)
    }

    /// 基于 keypath 排序，并返回排序后的新数组
    ///
    /// - Parameter path: 用于排序的 Key path，必须是 Comparable.
    /// - Parameter ascending: 是否升序
    /// - Returns: 排序后的数组
    func sorted<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            guard let lhsValue = lhs[keyPath: path], let rhsValue = rhs[keyPath: path] else { return false }
            return ascending ? (lhsValue < rhsValue) : (lhsValue > rhsValue)
        })
    }

    /// 基于 keypath 排序，并返回排序后的新数组
    ///
    /// - Parameter path: 用于排序的 Key path，必须是 Comparable.
    /// - Parameter ascending: 是否升序
    /// - Returns: Sorted array based on keyPath.
    func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            return ascending ? (lhs[keyPath: path] < rhs[keyPath: path]) : (lhs[keyPath: path] > rhs[keyPath: path])
        })
    }

    /// Array 元素根据 keypath 重新排序
    ///
    /// - Parameters:
    ///   - path: 用于排序的 Key path，必须是 Comparable.
    ///   - ascending: 是否升序
    /// - Returns: self after sorting.
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
    }

    /// Array 元素根据 keypath 重新排序
    ///
    /// - Parameters:
    ///   - path: 用于排序的 Key path，必须是 Comparable.
    ///   - ascending: 是否升序
    /// - Returns: self after sorting.
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
    }

}

// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {

    /// 移除数组中指定元素
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: 被移除的 item
    /// - Returns: 移除所有指定元素后返回 self
    @discardableResult
    mutating func remove(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }

    /// 移除数组中指定一组元素
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///        ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    ///
    /// - Parameter items: items to remove.
    /// - Returns: self after removing all instances of all items in given array.
    @discardableResult
    mutating func removeFrom(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }

    /// 去除数组中的重复元素
    ///
    ///        [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
    ///
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }

    /// 返回一个没有重复数据的数组
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

}
