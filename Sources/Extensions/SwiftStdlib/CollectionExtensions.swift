//
//  CollectionExtensions.swift
//  SwifterSwift
//
//  Created by Sergey Fedortsov on 19.12.16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Methods
public extension Collection {

    /// 并发的形式为每个元素执行闭包
    ///
    ///        array.forEachInParallel { item in
    ///            print(item)
    ///        }
    ///
    /// - Parameter each: 函数闭包
    func forEachInParallel(_ each: (Self.Element) -> Void) {
        let indicesArray = Array(indices)

        DispatchQueue.concurrentPerform(iterations: indicesArray.count) { (index) in
            let elementIndex = indicesArray[index]
            each(self[elementIndex])
        }
    }

    /// 安排通过下表访问集合的元素
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safe: 1] -> 2
    ///        arr[safe: 10] -> nil
    ///
    /// - Parameter index: 下标
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Methods (Int)
public extension Collection where Index == Int {

    /// 获取满足条件的第一个d元素的索引。
    ///
    ///        [1, 7, 1, 2, 4, 1, 6].firstIndex { $0 % 2 == 0 } -> 3
    ///
    /// - Parameter condition: 条件闭包
    /// - Returns: index 索引 (optional)
    func firstIndex(where condition: (Element) throws -> Bool) rethrows -> Index? {
        for (index, value) in lazy.enumerated() where try condition(value) {
            return index
        }
        return nil
    }

    /// 获取满足条件的最后一个元素的索引。
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].lastIndex { $0 % 2 == 0 } -> 6
    ///
    /// - Parameter condition: 条件闭包
    /// - Returns: index 索引 (optional)
    func lastIndex(where condition: (Element) throws -> Bool) rethrows -> Index? {
        for (index, value) in lazy.enumerated().reversed() where try condition(value) {
            return index
        }
        return nil
    }

    /// 获取满足条件的所有索引
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].indices(where: { $0 == 1 }) -> [0, 2, 5]
    ///
    /// - Parameter condition: 条件闭包
    /// - Returns: 索引集合. (optional)
    func indices(where condition: (Element) throws -> Bool) rethrows -> [Index]? {
        var indicies: [Index] = []
        for (index, value) in lazy.enumerated() where try condition(value) {
            indicies.append(index)
        }
        return indicies.isEmpty ? nil : indicies
    }

    /// 集合分割成指定大小，调用指定闭包。
    ///
    ///     [0, 2, 4, 7].forEach(slice: 2) { print($0) } -> //print: [0, 2], [4, 7]
    ///     [0, 2, 4, 7, 6].forEach(slice: 2) { print($0) } -> //print: [0, 2], [4, 7], [6]
    ///
    /// - Parameters:
    ///   - slice: 分割数组的长度
    ///   - body: a closure that takes an array of slice size as a parameter.
    func forEach(slice: Int, body: ([Element]) throws -> Void) rethrows {
        guard slice > 0, !isEmpty else { return }

        var value: Int = 0
        while value < count {
            try body(Array(self[Swift.max(value, startIndex)..<Swift.min(value + slice, endIndex)]))
            value += slice
        }
    }

    /// 按给定 size 创建一个二维数组
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: 单个数组的大小
    /// - Returns: 返回一个指定 size 的二维数组
    func group(by size: Int) -> [[Element]]? {
        //Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var value: Int = 0
        var slices: [[Element]] = []
        while value < count {
            slices.append(Array(self[Swift.max(value, startIndex)..<Swift.min(value + size, endIndex)]))
            value += size
        }
        return slices
    }

}

public extension Collection where Element: Equatable, Index == Int {

    /// 返回第一个等于给定元素的元素索引
    ///
    ///        [1, 2, 2, 3, 4, 2, 5].firstIndex(of: 2) -> 1
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].firstIndex(of: 6.5) -> nil
    ///        ["h", "e", "l", "l", "o"].firstIndex(of: "l") -> 2
    ///
    /// - Parameter item: item to check.
    /// - Returns: first index of item in array (if exists).
    func firstIndex(of item: Element) -> Index? {
        for (index, value) in lazy.enumerated() where value == item {
            return index
        }
        return nil
    }

    /// 返回等于给定元素的最后一个索引
    ///
    ///        [1, 2, 2, 3, 4, 2, 5].lastIndex(of: 2) -> 5
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].lastIndex(of: 6.5) -> nil
    ///        ["h", "e", "l", "l", "o"].lastIndex(of: "l") -> 3
    ///
    /// - Parameter item: item to check.
    /// - Returns: last index of item in array (if exists).
    func lastIndex(of item: Element) -> Index? {
        for (index, value) in lazy.enumerated().reversed() where value == item {
            return index
        }
        return nil
    }

}

// MARK: - Methods (Integer)
public extension Collection where Element == IntegerLiteralType, Index == Int {

    /// 整数集合求平均值
    ///
    /// - Returns: 数组的平均值。
    func average() -> Double {
        // http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }

}

// MARK: - Methods (FloatingPoint)
public extension Collection where Element: FloatingPoint {

    /// 小数集合的平均值
    ///
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: 数组的平均值。
    func average() -> Element {
        return isEmpty ? 0 : reduce(0, {$0 + $1}) / Element(count)
    }

}
