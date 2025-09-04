import Foundation
import UIKit

// MARK: - Crystal Error Handler Implementation for CrystalDrop Dropfall

class CrystalDropCrystalErrorHandler: ObservableObject {
    static let shared = CrystalDropCrystalErrorHandler()
    
    @Published var currentCrystalError: CrystalDropCrystalError?
    @Published var gemErrorHistory: [CrystalDropCrystalErrorLog] = []
    
    private let gemAnalytics = CrystalDropCrystalAnalytics.shared
    private let gemVibrations = CrystalDropVibrationManager.shared
    
    enum CrystalDropCrystalError: LocalizedError, Equatable {
        case gemNetworkUnavailable
        case invalidCrystalGameData
        case gemSecurityValidationFailed
        case prismWebViewLoadFailed(String)
        case gemAudioInitializationFailed
        case gemPermissionDenied(String)
        case unexpectedCrystalError(String)
        
        var errorDescription: String? {
            switch self {
            case .gemNetworkUnavailable:
                return "Crystal network unavailable. Check your internet connection."
            case .invalidCrystalGameData:
                return "Invalid gem game data. Try restarting the app."
            case .gemSecurityValidationFailed:
                return "Crystal security validation failed. Contact support."
            case .prismWebViewLoadFailed(let details):
                return "Failed to load gem game: \(details)"
            case .gemAudioInitializationFailed:
                return "Failed to initialize gem audio system."
            case .gemPermissionDenied(let permission):
                return "Access to \(permission) denied. Check app settings."
            case .unexpectedCrystalError(let message):
                return "Unexpected gem error: \(message)"
            }
        }
        
        var gemRecoverySuggestion: String? {
            switch self {
            case .gemNetworkUnavailable:
                return "Check Wi-Fi or cellular connection and try again."
            case .invalidCrystalGameData:
                return "Restart the app or reinstall it."
            case .gemSecurityValidationFailed:
                return "Make sure the app is updated to the latest version."
            case .prismWebViewLoadFailed:
                return "Check internet connection and try again."
            case .gemAudioInitializationFailed:
                return "Restart the app or check audio settings."
            case .gemPermissionDenied:
                return "Go to Settings > Privacy and grant necessary permissions."
            case .unexpectedCrystalError:
                return "Restart the app. If problem persists, contact support."
            }
        }
    }
    
    struct CrystalDropCrystalErrorLog: Codable, Identifiable {
        let id = UUID()
        let timestamp: Date
        let error: String
        let context: String
        let gemDeviceInfo: String
        
        init(error: CrystalDropCrystalError, context: String = "") {
            self.timestamp = Date()
            self.error = error.localizedDescription
            self.context = context
            self.gemDeviceInfo = "\(UIDevice.current.model) - iOS \(UIDevice.current.systemVersion)"
        }
    }
    
    private init() {}
    
    func handleCrystalError(_ error: CrystalDropCrystalError, context: String = "") {
        DispatchQueue.main.async {
            self.currentCrystalError = error
            
            let errorLog = CrystalDropCrystalErrorLog(error: error, context: context)
            self.gemErrorHistory.append(errorLog)
            
            // Keep only last 60 gem errors
            if self.gemErrorHistory.count > 60 {
                self.gemErrorHistory.removeFirst()
            }
            
            // Record crash in gem analytics
            let nsError = NSError(domain: "CrystalDropCrystalErrorDomain", 
                                code: self.getCrystalErrorCode(for: error), 
                                userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            self.gemAnalytics.recordCrystalCrash(error: nsError, stackTrace: context)
            
            // Provide gem haptic feedback
            self.gemVibrations.gemError()
        }
    }
    
    private func getCrystalErrorCode(for error: CrystalDropCrystalError) -> Int {
        switch error {
        case .gemNetworkUnavailable: return 2001
        case .invalidCrystalGameData: return 2002
        case .gemSecurityValidationFailed: return 2003
        case .prismWebViewLoadFailed: return 2004
        case .gemAudioInitializationFailed: return 2005
        case .gemPermissionDenied: return 2006
        case .unexpectedCrystalError: return 2999
        }
    }
    
    func clearCurrentCrystalError() {
        currentCrystalError = nil
    }
    
    func clearCrystalErrorHistory() {
        gemErrorHistory.removeAll()
    }
    
    func getCrystalErrorReport() -> String {
        let recentErrors = gemErrorHistory.suffix(12)
        var report = "CrystalDrop Dropfall Crystal Error Report\n"
        report += "======================================\n"
        report += "Recent Crystal Errors (\(recentErrors.count)):\n\n"
        
        for errorLog in recentErrors {
            report += "[\(errorLog.timestamp)] \(errorLog.error)\n"
            if !errorLog.context.isEmpty {
                report += "Context: \(errorLog.context)\n"
            }
            report += "Device: \(errorLog.gemDeviceInfo)\n\n"
        }
        
        return report
    }
}
