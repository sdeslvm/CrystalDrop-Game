import Foundation
import SwiftUI
import UIKit

// MARK: - Crystal Accessibility Manager Implementation for CrystalDrop Dropfall

class CrystalDropCrystalAccessibilityManager: ObservableObject {
    static let shared = CrystalDropCrystalAccessibilityManager()
    
    @Published var isCrystalVoiceOverEnabled: Bool = false
    @Published var isCrystalReduceMotionEnabled: Bool = false
    @Published var isCrystalHighContrastEnabled: Bool = false
    @Published var gemFontSizeMultiplier: CGFloat = 1.0
    
    private init() {
        checkCrystalAccessibilitySettings()
        setupCrystalAccessibilityNotifications()
    }
    
    private func checkCrystalAccessibilitySettings() {
        isCrystalVoiceOverEnabled = UIAccessibility.isVoiceOverRunning
        isCrystalReduceMotionEnabled = UIAccessibility.isReduceMotionEnabled
        isCrystalHighContrastEnabled = UIAccessibility.isDarkerSystemColorsEnabled
        
        if UIAccessibility.prefersCrossFadeTransitions {
            gemFontSizeMultiplier = 1.3
        }
    }
    
    private func setupCrystalAccessibilityNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIAccessibility.voiceOverStatusDidChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            self.isCrystalVoiceOverEnabled = UIAccessibility.isVoiceOverRunning
        }
        
        NotificationCenter.default.addObserver(
            forName: UIAccessibility.reduceMotionStatusDidChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            self.isCrystalReduceMotionEnabled = UIAccessibility.isReduceMotionEnabled
        }
    }
    
    func getCrystalAccessibilityLabel(for element: String) -> String {
        switch element {
        case "gem_button":
            return "Crystal button. Tap to interact with gem drop."
        case "drop_collection":
            return "Drop collection. Tap to collect gem drops."
        case "prism_settings":
            return "Prism settings. Tap to open gem settings."
        case "game_score":
            return "Game score. Current gem score displayed here."
        default:
            return element
        }
    }
    
    func getCrystalAccessibilityHint(for element: String) -> String {
        switch element {
        case "gem_button":
            return "Double tap to activate gem power"
        case "drop_collection":
            return "Double tap to collect all gem drops"
        case "prism_settings":
            return "Double tap to open gem settings menu"
        default:
            return ""
        }
    }
    
    func announceToCrystalVoiceOver(_ message: String) {
        if isCrystalVoiceOverEnabled {
            UIAccessibility.post(notification: .announcement, argument: message)
        }
    }
    
    func focusOnCrystalElement(_ element: UIView) {
        if isCrystalVoiceOverEnabled {
            UIAccessibility.post(notification: .layoutChanged, argument: element)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
