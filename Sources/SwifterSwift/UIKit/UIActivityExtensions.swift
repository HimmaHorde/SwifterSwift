// UIActivityExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - ActivityType

public extension UIActivity.ActivityType {
    /// SS: AddToiCloudDrive
    static let addToiCloudDrive = UIActivity.ActivityType("com.apple.CloudDocsUI.AddToiCloudDrive")

    /// SS: WhatsApp share extension
    static let postToWhatsApp = UIActivity.ActivityType("net.whatsapp.WhatsApp.ShareExtension")

    /// SS: LinkedIn share extension
    static let postToLinkedIn = UIActivity.ActivityType("com.linkedin.LinkedIn.ShareExtension")

    /// SS: XING share extension
    static let postToXing = UIActivity.ActivityType("com.xing.XING.Xing-Share")
}

#endif
