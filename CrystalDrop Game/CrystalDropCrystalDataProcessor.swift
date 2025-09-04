import Foundation
import Combine

// MARK: - Crystal Data Processor for CrystalDrop Dropfall

class CrystalDropCrystalDataProcessor: ObservableObject {
    @Published var gemProcessingState: CrystalProcessingState = .gemIdle
    @Published var gemDataCache: [String: Any] = [:]
    
    private var gemProcessingQueue = DispatchQueue(label: "crystal.gem.processing", qos: .userInitiated)
    private var gemCancellables = Set<AnyCancellable>()
    
    enum CrystalProcessingState {
        case gemIdle
        case gemProcessing
        case gemCompleted
        case gemFailed(Error)
    }
    
    func processCrystalGameData(_ rawData: Data) -> AnyPublisher<[String: Any], Error> {
        return Future { [weak self] promise in
            self?.gemProcessingQueue.async {
                do {
                    let processedData = try self?.parseCrystalData(rawData) ?? [:]
                    DispatchQueue.main.async {
                        self?.gemDataCache.merge(processedData) { _, new in new }
                        self?.gemProcessingState = .gemCompleted
                        promise(.success(processedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.gemProcessingState = .gemFailed(error)
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func parseCrystalData(_ data: Data) throws -> [String: Any] {
        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw CrystalDropCrystalDataError.invalidCrystalFormat
        }
        
        var processedCrystalData: [String: Any] = [:]
        
        // Process gem game configuration
        if let gameConfig = jsonObject["gameConfig"] as? [String: Any] {
            processedCrystalData["crystalConfig"] = transformCrystalGameConfig(gameConfig)
        }
        
        // Process gem user data
        if let userData = jsonObject["userData"] as? [String: Any] {
            processedCrystalData["crystalUserData"] = sanitizeCrystalUserData(userData)
        }
        
        // Process gem settings
        if let settings = jsonObject["settings"] as? [String: Any] {
            processedCrystalData["crystalSettings"] = optimizeCrystalSettings(settings)
        }
        
        return processedCrystalData
    }
    
    private func transformCrystalGameConfig(_ config: [String: Any]) -> [String: Any] {
        var transformed: [String: Any] = [:]
        
        for (key, value) in config {
            let newKey = "crystalgem_" + key.lowercased()
            transformed[newKey] = value
        }
        
        return transformed
    }
    
    private func sanitizeCrystalUserData(_ userData: [String: Any]) -> [String: Any] {
        var sanitized: [String: Any] = [:]
        
        let allowedCrystalKeys = ["score", "level", "achievements", "preferences", "gems", "drops"]
        
        for key in allowedCrystalKeys {
            if let value = userData[key] {
                sanitized["gemuser_" + key] = value
            }
        }
        
        return sanitized
    }
    
    private func optimizeCrystalSettings(_ settings: [String: Any]) -> [String: Any] {
        var optimized: [String: Any] = [:]
        
        for (key, value) in settings {
            if let stringValue = value as? String {
                optimized[key] = CrystalDropCrystalSecurityLayer.shared.encryptCrystalData(stringValue)
            } else {
                optimized[key] = value
            }
        }
        
        return optimized
    }
    
    func clearCrystalCache() {
        gemDataCache.removeAll()
        gemProcessingState = .gemIdle
    }
    
    func getCachedCrystalData(for key: String) -> Any? {
        return gemDataCache[key]
    }
}

// MARK: - Crystal Error Handling Implementation

enum CrystalDropCrystalDataError: Error, LocalizedError {
    case invalidCrystalFormat
    case gemProcessingFailed
    case gemCacheMiss
    
    var errorDescription: String? {
        switch self {
        case .invalidCrystalFormat:
            return "Invalid gem data format for CrystalDrop Dropfall"
        case .gemProcessingFailed:
            return "Crystal data processing failed for CrystalDrop Dropfall"
        case .gemCacheMiss:
            return "Crystal data not found in CrystalDrop cache"
        }
    }
}
