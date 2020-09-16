// CLVisitExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(CoreLocation) && (os(iOS) || targetEnvironment(macCatalyst))
import CoreLocation

// MARK: - Properties

public extension CLVisit {
    /// SS: Retrieves a visit's location.
    ///
    /// - Returns: CLLocation
    var location: CLLocation {
        return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

#endif
