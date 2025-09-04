import Foundation
import SwiftUI
import UIKit

// MARK: - Crystal Theme Engine Implementation for CrystalDrop Dropfall

class CrystalDropCrystalThemeEngine: ObservableObject {
    static let shared = CrystalDropCrystalThemeEngine()
    
    @Published var currentCrystalTheme: CrystalDropCrystalTheme = .prismDrop
    @Published var isDarkCrystalMode: Bool = false
    
    enum CrystalDropCrystalTheme: String, CaseIterable {
        case prismDrop = "prism_drop"
        case amethystFall = "amethyst_fall"
        case gemCore = "gem_core"
        case dropStorm = "drop_storm"
        
        var displayName: String {
            switch self {
            case .prismDrop: return "Prism Drop"
            case .amethystFall: return "Amethyst Fall"
            case .gemCore: return "Crystal Core"
            case .dropStorm: return "Drop Storm"
            }
        }
        
        var primaryCrystalColor: String {
            switch self {
            case .prismDrop: return "#335D8D"
            case .amethystFall: return "#1a2f3f"
            case .gemCore: return "#0a1a26"
            case .dropStorm: return "#2a3f4f"
            }
        }
        
        var secondaryCrystalColor: String {
            switch self {
            case .prismDrop: return "#3f5f7f"
            case .amethystFall: return "#4f6f8f"
            case .gemCore: return "#2a3f4f"
            case .dropStorm: return "#1a2f3f"
            }
        }
        
        var accentCrystalColor: String {
            switch self {
            case .prismDrop: return "#6f8faf"
            case .amethystFall: return "#5f7f9f"
            case .gemCore: return "#4f6f8f"
            case .dropStorm: return "#3f5f7f"
            }
        }
    }
    
    private init() {
        loadCrystalThemeSettings()
    }
    
    private func loadCrystalThemeSettings() {
        if let themeString = UserDefaults.standard.string(forKey: "CrystalDropCrystalCurrentTheme"),
           let theme = CrystalDropCrystalTheme(rawValue: themeString) {
            currentCrystalTheme = theme
        }
        isDarkCrystalMode = UserDefaults.standard.bool(forKey: "CrystalDropCrystalDarkMode")
    }
    
    func saveCrystalThemeSettings() {
        UserDefaults.standard.set(currentCrystalTheme.rawValue, forKey: "CrystalDropCrystalCurrentTheme")
        UserDefaults.standard.set(isDarkCrystalMode, forKey: "CrystalDropCrystalDarkMode")
    }
    
    func setCrystalTheme(_ theme: CrystalDropCrystalTheme) {
        currentCrystalTheme = theme
        saveCrystalThemeSettings()
    }
    
    func toggleCrystalDarkMode() {
        isDarkCrystalMode.toggle()
        saveCrystalThemeSettings()
    }
    
    func getPrimaryCrystalColor() -> Color {
        return Color.gemDropTheme(hex: currentCrystalTheme.primaryCrystalColor)
    }
    
    func getSecondaryCrystalColor() -> Color {
        return Color.gemDropTheme(hex: currentCrystalTheme.secondaryCrystalColor)
    }
    
    func getAccentCrystalColor() -> Color {
        return Color.gemDropTheme(hex: currentCrystalTheme.accentCrystalColor)
    }
    
    func getCrystalBackgroundGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [
                getPrimaryCrystalColor().opacity(0.8),
                getSecondaryCrystalColor().opacity(0.6)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
