//
//  BoolExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension Bool {

    /// true 返回 1 ，false 返回 0
    ///
    ///        false.int -> 0
    ///        true.int -> 1
    ///
    var int: Int {
        return self ? 1 : 0
    }
}
