// SKNodeExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(SpriteKit)
import SpriteKit

// MARK: - Methods

public extension SKNode {
    /// SS: Return an array of all SKNode descendants
    ///
    ///         mySKNode.descendants() -> [childNodeOne, childNodeTwo]
    ///
    func descendants() -> [SKNode] {
        var children = self.children
        children.append(contentsOf: children.reduce(into: [SKNode]()) { $0.append(contentsOf: $1.descendants()) })
        return children
    }

    /// SS: The center anchor of the node in its parent's coordinate system.
    ///
    ///         mySKNode.center = CGPoint(x: frame.midX, y: frame.midY)
    ///
    var center: CGPoint {
        get {
            let contents = calculateAccumulatedFrame()
            return CGPoint(x: contents.midX, y: contents.midY)
        }
        set {
            let contents = calculateAccumulatedFrame()
            position = CGPoint(x: newValue.x - contents.midX, y: newValue.y - contents.midY)
        }
    }

    /// SS: The top left anchor of the node in its parent's coordinate system.
    ///
    ///         mySKNode.topLeft = CGPoint(x: frame.minX, y: frame.maxY)
    ///
    var topLeft: CGPoint {
        get {
            let contents = calculateAccumulatedFrame()
            return CGPoint(x: contents.minX, y: contents.maxY)
        }
        set {
            let contents = calculateAccumulatedFrame()
            position = CGPoint(x: newValue.x - contents.minX, y: newValue.y - contents.maxY)
        }
    }

    /// SS: The top right anchor of the node in its parent's coordinate system.
    ///
    ///         mySKNode.topRight = CGPoint(x: frame.maxX, y: frame.maxY)
    ///
    var topRight: CGPoint {
        get {
            let contents = calculateAccumulatedFrame()
            return CGPoint(x: contents.maxX, y: contents.maxY)
        }
        set {
            let contents = calculateAccumulatedFrame()
            position = CGPoint(x: newValue.x - contents.maxX, y: newValue.y - contents.maxY)
        }
    }

    /// SS: The bottom left anchor of the node in its parent's coordinate system.
    ///
    ///         mySKNode.center = GPoint(x: frame.minX, y: frame.minY)
    ///
    var bottomLeft: CGPoint {
        get {
            let contents = calculateAccumulatedFrame()
            return CGPoint(x: contents.minX, y: contents.minY)
        }
        set {
            let contents = calculateAccumulatedFrame()
            position = CGPoint(x: newValue.x - contents.minX, y: newValue.y - contents.minY)
        }
    }

    /// SS: The bottom right anchor of the node in its parent's coordinate system.
    ///
    ///         mySKNode.bottomRight = CGPoint(x: frame.maxX, y: frame.minY)
    ///
    var bottomRight: CGPoint {
        get {
            let contents = calculateAccumulatedFrame()
            return CGPoint(x: contents.maxX, y: contents.minY)
        }
        set {
            let contents = calculateAccumulatedFrame()
            position = CGPoint(x: newValue.x - contents.maxX, y: newValue.y - contents.minY)
        }
    }
}

#endif
