//
//  CollectionExtensions.swift
//  SwifterSwift
//
//  Created by Sergey Fedortsov on 19.12.16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Dispatch)
import Dispatch
#endif

// MARK: - Methods
public extension Collection {

    #if canImport(Dispatch)
    /// SS: 并发的形式为每个元素执行闭包
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
    #endif

    /// SS: 安排通过下表访问集合的元素
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safe: 1] -> 2
    ///        arr[safe: 10] -> nil
    ///
    /// - Parameter index: 下标
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    /// SS: 返回一个二维数组，按指定的大小均匀分割元数组，最后一个数组是剩余的元素
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: 单个数组的大小
    /// - Returns: 二维数组
    func group(by size: Int) -> [[Element]]? {
        // Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var start = startIndex
        var slices = [[Element]]()
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            slices.append(Array(self[start..<end]))
            start = end
        }
        return slices
    }

}

// MARK: - Methods (Int)
public extension Collection where Index == Int {
    /// SS: 获取满足条件的所有索引
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

    /// SS: 集合分割成指定大小，调用指定闭包。
    ///
    ///     [0, 2, 4, 7].forEach(slice: 2) { print($0) } -> // print: [0, 2], [4, 7]
    ///     [0, 2, 4, 7, 6].forEach(slice: 2) { print($0) } -> // print: [0, 2], [4, 7], [6]
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
}

public extension Collection where Element: Equatable, Index == Int {

}

// MARK: - Methods (Integer)
public extension Collection where Element == IntegerLiteralType, Index == Int {

    /// SS: 整数集合求平均值
    ///
    /// - Returns: 数组的平均值。
    func average() -> Double {
        // http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }

}

// MARK: - Methods (FloatingPoint)
public extension Collection where Element: FloatingPoint {

    /// SS: 小数集合的平均值
    ///
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: average of the array's elements.
    func average() -> Element {
        guard !isEmpty else { return 0 }
        return reduce(0, {$0 + $1}) / Element(count)
    }
}
