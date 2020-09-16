// UITextViewExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UITextView {
    /// SS: Clear text.
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// SS: Scroll to the bottom of text view
    func scrollToBottom() {
        // swiftlint:disable:next legacy_constructor
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }

    /// SS: Scroll to the top of text view
    func scrollToTop() {
        // swiftlint:disable:next legacy_constructor
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }

    /// SS: Wrap to the content (Text / Attributed Text).
    func wrapToContent() {
        contentInset = .zero
        scrollIndicatorInsets = .zero
        contentOffset = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }
}

#endif
