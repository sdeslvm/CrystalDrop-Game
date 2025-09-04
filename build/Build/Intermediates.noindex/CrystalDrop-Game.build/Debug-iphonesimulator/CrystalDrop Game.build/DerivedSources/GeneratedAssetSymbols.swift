import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "CrystalDropLogo" asset catalog image resource.
    static let crystalDropLogo = ImageResource(name: "CrystalDropLogo", bundle: resourceBundle)

    /// The "asset1" asset catalog image resource.
    static let asset1 = ImageResource(name: "asset1", bundle: resourceBundle)

    /// The "asset2" asset catalog image resource.
    static let asset2 = ImageResource(name: "asset2", bundle: resourceBundle)

    /// The "asset3" asset catalog image resource.
    static let asset3 = ImageResource(name: "asset3", bundle: resourceBundle)

    /// The "asset4" asset catalog image resource.
    static let asset4 = ImageResource(name: "asset4", bundle: resourceBundle)

    /// The "asset5" asset catalog image resource.
    static let asset5 = ImageResource(name: "asset5", bundle: resourceBundle)

    /// The "asset6" asset catalog image resource.
    static let asset6 = ImageResource(name: "asset6", bundle: resourceBundle)

    /// The "asset7" asset catalog image resource.
    static let asset7 = ImageResource(name: "asset7", bundle: resourceBundle)

    /// The "asset8" asset catalog image resource.
    static let asset8 = ImageResource(name: "asset8", bundle: resourceBundle)

    /// The "ball" asset catalog image resource.
    static let ball = ImageResource(name: "ball", bundle: resourceBundle)

    /// The "logo" asset catalog image resource.
    static let logo = ImageResource(name: "logo", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "CrystalDropLogo" asset catalog image.
    static var crystalDropLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .crystalDropLogo)
#else
        .init()
#endif
    }

    /// The "asset1" asset catalog image.
    static var asset1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset1)
#else
        .init()
#endif
    }

    /// The "asset2" asset catalog image.
    static var asset2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset2)
#else
        .init()
#endif
    }

    /// The "asset3" asset catalog image.
    static var asset3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset3)
#else
        .init()
#endif
    }

    /// The "asset4" asset catalog image.
    static var asset4: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset4)
#else
        .init()
#endif
    }

    /// The "asset5" asset catalog image.
    static var asset5: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset5)
#else
        .init()
#endif
    }

    /// The "asset6" asset catalog image.
    static var asset6: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset6)
#else
        .init()
#endif
    }

    /// The "asset7" asset catalog image.
    static var asset7: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset7)
#else
        .init()
#endif
    }

    /// The "asset8" asset catalog image.
    static var asset8: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .asset8)
#else
        .init()
#endif
    }

    /// The "ball" asset catalog image.
    static var ball: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ball)
#else
        .init()
#endif
    }

    /// The "logo" asset catalog image.
    static var logo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logo)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "CrystalDropLogo" asset catalog image.
    static var crystalDropLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .crystalDropLogo)
#else
        .init()
#endif
    }

    /// The "asset1" asset catalog image.
    static var asset1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset1)
#else
        .init()
#endif
    }

    /// The "asset2" asset catalog image.
    static var asset2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset2)
#else
        .init()
#endif
    }

    /// The "asset3" asset catalog image.
    static var asset3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset3)
#else
        .init()
#endif
    }

    /// The "asset4" asset catalog image.
    static var asset4: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset4)
#else
        .init()
#endif
    }

    /// The "asset5" asset catalog image.
    static var asset5: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset5)
#else
        .init()
#endif
    }

    /// The "asset6" asset catalog image.
    static var asset6: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset6)
#else
        .init()
#endif
    }

    /// The "asset7" asset catalog image.
    static var asset7: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset7)
#else
        .init()
#endif
    }

    /// The "asset8" asset catalog image.
    static var asset8: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .asset8)
#else
        .init()
#endif
    }

    /// The "ball" asset catalog image.
    static var ball: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ball)
#else
        .init()
#endif
    }

    /// The "logo" asset catalog image.
    static var logo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logo)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif