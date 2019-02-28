//
//  BidirectionalCollectionExtensions.swift
//  SwifterSwift
//
//  Created by Quentin Jin on 2018/10/13.
//  Copyright © 2018 SwifterSwift
//

// MARK: - Methods
public extension BidirectionalCollection {

    /// 通过下标获取集合的元素，正整数下标正向查找，负数反向查找
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[offset: 1] -> 2
    ///        arr[offset: -2] -> 4
    ///
    /// - Parameter distance: 偏移量.
    subscript(offset distance: Int) -> Element {
        let index = distance >= 0 ? startIndex : endIndex
        return self[indices.index(index, offsetBy: distance)]
    }

}
