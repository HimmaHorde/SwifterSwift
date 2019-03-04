//
//  NSAttributedStringTests.swift
//  SwifterSwift
//
//  Created by Ewelina on 26/01/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class NSAttributedStringExtensionsTests: XCTestCase {

    #if !os(macOS) && !os(tvOS)
    func testApplyingToRegex() {
        let email = "steve.jobs@apple.com"
        let testString = NSAttributedString(string: "Your email is \(email)!")
        let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.blue]
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let attrTestString = testString.applying(attributes: attributes, toRangesMatching: pattern)

        let attrAtBeginning = attrTestString.attributes(at: 0, effectiveRange: nil)
        XCTAssert(attrAtBeginning.count == 1)

        var passed = false
        // iterate through each range of attributes
        attrTestString.enumerateAttributes(in: NSRange(0..<attrTestString.length), options: .longestEffectiveRangeNotRequired) { attrs, range, _ in

            let emailFromRange = attrTestString.attributedSubstring(from: range).string

            // exit if there are not more attributes for the subsequence than what was there originally
            guard attrs.count > attrAtBeginning.count else { return }

            // confirm that the string with the applied attributes is the email
            XCTAssertEqual(emailFromRange, email)

            // the range contains the email, check to make sure the attributes are there and correct
            for attr in attrs {
                if attr.key == .underlineStyle {
                    XCTAssertEqual(attr.value as? NSUnderlineStyle.RawValue, NSUnderlineStyle.single.rawValue)
                    passed = true
                } else if attr.key == .foregroundColor {
                    XCTAssertEqual(attr.value as? UIColor, UIColor.blue)
                    passed = true
                } else if attr.key == .font {
                    XCTAssertEqual((attr.value as? UIFont), .boldSystemFont(ofSize: UIFont.systemFontSize))
                } else {
                    passed = false
                }
            }

            XCTAssert(passed)
        }
    }

    func testApplyingToOccurrences() {
        let name = "Steve Wozniak"
        let greeting = "Hello, \(name)."
        let attrGreeting = NSAttributedString(string: greeting).applying(
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                         .foregroundColor: UIColor.red], toOccurrencesOf: name)

        let attrAtBeginning = attrGreeting.attributes(at: 0, effectiveRange: nil)
        // assert that there is only one attribute at beginning from italics
        XCTAssertEqual(attrAtBeginning.count, 1)

        var passed = false
        // iterate through each range of attributes
        attrGreeting.enumerateAttributes(in: NSRange(0..<attrGreeting.length), options: .longestEffectiveRangeNotRequired) { attrs, range, _ in
            // exit if there are not more attributes for the subsequence than what was there originally
            guard attrs.count > attrAtBeginning.count else { return }

            // confirm that the attributed string is the name
            let stringAtRange = attrGreeting.attributedSubstring(from: range).string
            XCTAssertEqual(stringAtRange, name)

            for attr in attrs {
                if attr.key == .underlineStyle {
                    XCTAssertEqual(attr.value as? NSUnderlineStyle.RawValue, NSUnderlineStyle.single.rawValue)
                    passed = true
                } else if attr.key == .foregroundColor {
                    XCTAssertEqual(attr.value as? UIColor, UIColor.red)
                    passed = true
                } else if attr.key == .font {
                    XCTAssertEqual((attr.value as? UIFont), .italicSystemFont(ofSize: UIFont.systemFontSize))
                } else {
                    passed = false
                }
            }
        }

        XCTAssert(passed)
    }
    #endif

    #if !os(macOS) && !os(tvOS)
    func testAppending() {
        var string = NSAttributedString(string: "Test")
        string += NSAttributedString(string: " Appending")

        XCTAssertEqual(string.string, "Test Appending")

        var attributes = string.attributes(at: 0, effectiveRange: nil)
        var filteredAttributes = attributes.filter { (key, value) -> Bool in
            var valid = false
            if key == NSAttributedString.Key.font, let value = value as? UIFont, value == .italicSystemFont(ofSize: UIFont.systemFontSize) {
                valid = true
            }
            if key == NSAttributedString.Key.underlineStyle, let value = value as? NSUnderlineStyle.RawValue, value == NSUnderlineStyle.single.rawValue {
                valid = true
            }
            if key == NSAttributedString.Key.strikethroughStyle, let value = value as? NSUnderlineStyle.RawValue, value == NSUnderlineStyle.single.rawValue {
                valid = true
            }

            return valid
        }

        XCTAssertEqual(filteredAttributes.count, 3)

        attributes = string.attributes(at: 5, effectiveRange: nil)
        filteredAttributes = attributes.filter { (key, value) -> Bool in
            return (key == NSAttributedString.Key.font && (value as? UIFont) == .boldSystemFont(ofSize: UIFont.systemFontSize))
        }

        XCTAssertEqual(filteredAttributes.count, 1)
    }
    #endif

    #if !os(macOS) && !os(tvOS)
    // MARK: - Operators
    func testOperators() {
        var string1 = NSAttributedString(string: "Test")
        let string2 = NSAttributedString(string: " Appending")
        XCTAssertEqual((string1 + string2).string, "Test Appending")
        XCTAssertEqual((string1 + string2.string).string, "Test Appending")

        string1 += string2.string
        XCTAssertEqual(string1.string, "Test Appending")
    }
    #endif

}

#endif
