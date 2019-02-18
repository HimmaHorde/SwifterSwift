//
//  MKPolylineExtensions.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 3/8/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(MapKit)
import MapKit

// MARK: - Initializers
#if !os(watchOS)
@available(tvOS 9.2, *)
public extension MKPolyline {

    /// SwifterSwift: 根据指定的坐标数组,创建一个新的轨迹路线.
    ///
    /// - Parameter coordinates: Array of CLLocationCoordinate2D(s).
    convenience init(coordinates: [CLLocationCoordinate2D]) {
        var refCoordinates = coordinates
        self.init(coordinates: &refCoordinates, count: refCoordinates.count)
    }

}
#endif

#if !os(watchOS)
// MARK: - Properties
@available(tvOS 9.2, *)
public extension MKPolyline {

    /// SwifterSwift: Return an Array of coordinates representing the provided polyline.
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }

}
#endif

#endif
