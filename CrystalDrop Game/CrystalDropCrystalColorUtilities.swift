import Foundation
import SwiftUI
import UIKit

// MARK: - Crystal Color Utilities Implementation for CrystalDrop Dropfall

struct CrystalDropCrystalColorPalette {
    static let primaryDark = "#335D8D"
    static let secondaryDark = "#1a2f3f"
    static let darkBlue = "#0a1a26"
    static let lightDark = "#2a3f4f"
    static let accentDark = "#3f5f7f"
    static let highlightDark = "#4f6f8f"
    static let accentYellow = "#335D8D"
    static let accentOrange = "#4A6FA5"
}

extension UIColor {
    static func crystalColor(hex: String) -> UIColor {
        let sanitizedHex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var colorValue: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&colorValue)
        
        let redComponent = CGFloat((colorValue & 0xFF0000) >> 16) / 255.0
        let greenComponent = CGFloat((colorValue & 0x00FF00) >> 8) / 255.0
        let blueComponent = CGFloat(colorValue & 0x0000FF) / 255.0
        
        return UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1.0)
    }
    
    static func crystalGradientColors() -> [CGColor] {
        return [
            UIColor.crystalColor(hex: CrystalDropCrystalColorPalette.primaryDark).cgColor,
            UIColor.crystalColor(hex: CrystalDropCrystalColorPalette.secondaryDark).cgColor,
            UIColor.crystalColor(hex: CrystalDropCrystalColorPalette.accentDark).cgColor
        ]
    }
}

extension Color {
    static func gemDropTheme(hex: String) -> Color {
        let sanitizedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        var colorValue: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&colorValue)
        
        return Color(
            .sRGB,
            red: Double((colorValue >> 16) & 0xFF) / 255.0,
            green: Double((colorValue >> 8) & 0xFF) / 255.0,
            blue: Double(colorValue & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
}

// MARK: - Crystal Animation Configuration

struct CrystalDropDropAnimationConfig {
    static let defaultDuration: Double = 0.9
    static let pulseDuration: Double = 1.4
    static let shimmerDuration: Double = 2.2
    
    static func createCrystalAnimation() -> Animation {
        return Animation.easeInOut(duration: pulseDuration).repeatForever(autoreverses: true)
    }
    
    static func createDropAnimation() -> Animation {
        return Animation.linear(duration: shimmerDuration).repeatForever(autoreverses: false)
    }
}
