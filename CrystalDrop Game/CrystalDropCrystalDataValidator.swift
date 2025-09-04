import Foundation
import Network

// MARK: - Crystal Data Validator Implementation for CrystalDrop Dropfall

class CrystalDropCrystalDataValidator: ObservableObject {
    static let shared = CrystalDropCrystalDataValidator()
    
    @Published var isCrystalValidationInProgress: Bool = false
    @Published var lastCrystalValidationResult: CrystalDropCrystalValidationResult?
    
    enum CrystalDropCrystalValidationResult {
        case gemSuccess
        case gemNetworkError
        case invalidCrystalData
        case gemSecurityViolation
        case gemServerError(String)
        
        var description: String {
            switch self {
            case .gemSuccess:
                return "Crystal data successfully validated"
            case .gemNetworkError:
                return "Network error during gem validation"
            case .invalidCrystalData:
                return "Invalid gem drop data"
            case .gemSecurityViolation:
                return "Crystal security violation detected"
            case .gemServerError(let message):
                return "Crystal server error: \(message)"
            }
        }
    }
    
    private let gemNetworkMonitor = NWPathMonitor()
    private let gemMonitorQueue = DispatchQueue(label: "CrystalDropCrystalNetworkMonitor")
    
    private init() {
        setupCrystalNetworkMonitoring()
    }
    
    private func setupCrystalNetworkMonitoring() {
        gemNetworkMonitor.start(queue: gemMonitorQueue)
    }
    
    func validateCrystalData(_ data: [String: Any]) async -> CrystalDropCrystalValidationResult {
        isCrystalValidationInProgress = true
        defer { isCrystalValidationInProgress = false }
        
        // Check gem network connection
        guard gemNetworkMonitor.currentPath.status == .satisfied else {
            lastCrystalValidationResult = .gemNetworkError
            return .gemNetworkError
        }
        
        // Validate gem data structure
        guard validateCrystalDataStructure(data) else {
            lastCrystalValidationResult = .invalidCrystalData
            return .invalidCrystalData
        }
        
        // Validate gem security
        guard validateCrystalDataSecurity(data) else {
            lastCrystalValidationResult = .gemSecurityViolation
            return .gemSecurityViolation
        }
        
        // Validate on gem server
        do {
            let serverResult = try await validateOnCrystalServer(data)
            lastCrystalValidationResult = serverResult
            return serverResult
        } catch {
            let result = CrystalDropCrystalValidationResult.gemServerError(error.localizedDescription)
            lastCrystalValidationResult = result
            return result
        }
    }
    
    private func validateCrystalDataStructure(_ data: [String: Any]) -> Bool {
        let requiredCrystalKeys = ["gem_id", "drop_count", "prism_count", "level", "score"]
        
        for key in requiredCrystalKeys {
            guard data[key] != nil else {
                return false
            }
        }
        
        // Validate gem data types
        guard let dropCount = data["drop_count"] as? Int,
              let prismCount = data["prism_count"] as? Int,
              let level = data["level"] as? Int,
              let score = data["score"] as? Int else {
            return false
        }
        
        // Validate reasonable gem values
        return dropCount >= 0 && dropCount <= 2000 &&
               prismCount >= 0 && prismCount <= 15000 &&
               level >= 1 && level <= 150 &&
               score >= 0
    }
    
    private func validateCrystalDataSecurity(_ data: [String: Any]) -> Bool {
        let gemSecurityLayer = CrystalDropCrystalSecurityLayer.shared
        
        // Check for suspicious gem values
        for (key, value) in data {
            if let stringValue = value as? String {
                if !gemSecurityLayer.validateCrystalEndpoint(stringValue) && key.contains("url") {
                    return false
                }
            }
        }
        
        return true
    }
    
    private func validateOnCrystalServer(_ data: [String: Any]) async throws -> CrystalDropCrystalValidationResult {
        guard let url = URL(string: "https://gemdropgame.com/api/validate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("CrystalDropDropfall/3.0", forHTTPHeaderField: "User-Agent")
        
        let jsonData = try JSONSerialization.data(withJSONObject: data)
        request.httpBody = jsonData
        
        let (responseData, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200:
            return .gemSuccess
        case 400:
            return .invalidCrystalData
        case 403:
            return .gemSecurityViolation
        default:
            return .gemServerError("HTTP \(httpResponse.statusCode)")
        }
    }
    
    func validateCrystalURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString) else { return false }
        
        let allowedCrystalHosts = ["gemdropgame.com", "www.gemdropgame.com"]
        guard let host = url.host, allowedCrystalHosts.contains(host) else { return false }
        
        return url.scheme == "https"
    }
    
    deinit {
        gemNetworkMonitor.cancel()
    }
}
