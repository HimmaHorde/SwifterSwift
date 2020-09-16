// NSViewExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

// MARK: - Properties

public extension NSView {
    /// SS: Border color of view; also inspectable from Storyboard.
    @IBInspectable
    var borderColor: NSColor? {
        get {
            guard let color = layer?.borderColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.borderColor = newValue?.cgColor
        }
    }

    /// SS: Border width of view; also inspectable from Storyboard.
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer?.borderWidth ?? 0
        }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }

    /// SS: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer?.cornerRadius ?? 0
        }
        set {
            wantsLayer = true
            layer?.masksToBounds = true
            layer?.cornerRadius = newValue.magnitude
        }
    }

    // SS: Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    /// SS: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowColor: NSColor? {
        get {
            guard let color = layer?.shadowColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.shadowColor = newValue?.cgColor
        }
    }

    /// SS: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer?.shadowOffset ?? CGSize.zero
        }
        set {
            wantsLayer = true
            layer?.shadowOffset = newValue
        }
    }

    /// SS: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer?.shadowOpacity ?? 0
        }
        set {
            wantsLayer = true
            layer?.shadowOpacity = newValue
        }
    }

    /// SS: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer?.shadowRadius ?? 0
        }
        set {
            wantsLayer = true
            layer?.shadowRadius = newValue
        }
    }

    /// SS: Background color of the view; also inspectable from Storyboard.
    @IBInspectable
    var backgroundColor: NSColor? {
        get {
            if let colorRef = layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }

    /// SS: Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    /// SS: Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
}

// MARK: - Methods

public extension NSView {
    /// SS: Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [NSView]) {
        subviews.forEach { addSubview($0) }
    }

    /// SS: Remove all subviews in view.
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}

#endif
