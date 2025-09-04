import Foundation
import UIKit

// MARK: - Crystal Vibration Manager Implementation for CrystalDrop Dropfall

class CrystalDropVibrationManager: ObservableObject {
    static let shared = CrystalDropVibrationManager()
    
    @Published var isCrystalVibrationsEnabled: Bool = true
    
    private let gemLightImpact = UIImpactFeedbackGenerator(style: .light)
    private let gemMediumImpact = UIImpactFeedbackGenerator(style: .medium)
    private let gemHeavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    private let dropSelectionFeedback = UISelectionFeedbackGenerator()
    private let prismNotificationFeedback = UINotificationFeedbackGenerator()
    
    private let crystalDefaults = UserDefaults.standard
    
    private init() {
        loadCrystalVibrationSettings()
        prepareCrystalVibrations()
    }
    
    private func loadCrystalVibrationSettings() {
        isCrystalVibrationsEnabled = crystalDefaults.bool(forKey: "CrystalDropCrystalVibrationsEnabled")
        if crystalDefaults.object(forKey: "CrystalDropCrystalVibrationsEnabled") == nil {
            isCrystalVibrationsEnabled = true // Default to enabled
        }
    }
    
    private func prepareCrystalVibrations() {
        gemLightImpact.prepare()
        gemMediumImpact.prepare()
        gemHeavyImpact.prepare()
        dropSelectionFeedback.prepare()
        prismNotificationFeedback.prepare()
    }
    
    func saveCrystalVibrationSettings() {
        crystalDefaults.set(isCrystalVibrationsEnabled, forKey: "CrystalDropCrystalVibrationsEnabled")
    }
    
    func toggleCrystalVibrations() {
        isCrystalVibrationsEnabled.toggle()
        saveCrystalVibrationSettings()
    }
    
    // MARK: - Crystal Vibration Feedback Methods
    
    func dropTap() {
        guard isCrystalVibrationsEnabled else { return }
        gemLightImpact.impactOccurred()
    }
    
    func prismAction() {
        guard isCrystalVibrationsEnabled else { return }
        gemMediumImpact.impactOccurred()
    }
    
    func dropfallEffect() {
        guard isCrystalVibrationsEnabled else { return }
        gemHeavyImpact.impactOccurred()
    }
    
    func gemMenuSelection() {
        guard isCrystalVibrationsEnabled else { return }
        dropSelectionFeedback.selectionChanged()
    }
    
    func gemSuccess() {
        guard isCrystalVibrationsEnabled else { return }
        prismNotificationFeedback.notificationOccurred(.success)
    }
    
    func gemWarning() {
        guard isCrystalVibrationsEnabled else { return }
        prismNotificationFeedback.notificationOccurred(.warning)
    }
    
    func gemError() {
        guard isCrystalVibrationsEnabled else { return }
        prismNotificationFeedback.notificationOccurred(.error)
    }
    
    func crystalCustomPattern() {
        guard isCrystalVibrationsEnabled else { return }
        
        DispatchQueue.main.async {
            self.gemLightImpact.impactOccurred()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.gemMediumImpact.impactOccurred()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.gemLightImpact.impactOccurred()
                }
            }
        }
    }
}
