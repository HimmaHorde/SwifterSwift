//
//  UnicodeScalarExtensions.swift
//  SwifterSwift
//
//  Created by yanglin on 2019/2/27.
//  Copyright © 2019 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

#if canImport(Foundation)

// MARK: - 属性
public extension UnicodeScalar {

    /// SS: 是否是 emoji
    ///
    ///    [引用链接](https://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji)
    ///
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        127000...127600, // Various asian characters
        65024...65039, // Variation selector
        9100...9300, // Misc items
        8400...8447: // Combining Diacritical Marks for Symbols
            return true

        default: return false
        }
    }

    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}
#endif
